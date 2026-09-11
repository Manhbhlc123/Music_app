package com.Backend.music_app.service;


import com.Backend.music_app.dto.request.AuthenticationRequest;
import com.Backend.music_app.dto.request.IntrospectRequest;
import com.Backend.music_app.dto.request.LogoutRequest;
import com.Backend.music_app.dto.request.RefreshRequest;
import com.Backend.music_app.dto.response.AuthenticationResponse;
import com.Backend.music_app.dto.response.IntrospectResponse;
import com.Backend.music_app.entity.InvalidToken;
import com.Backend.music_app.entity.User;
import com.Backend.music_app.exception.AppException;
import com.Backend.music_app.exception.ErrorCode;
import com.Backend.music_app.repository.InvalidTokenReponsitory;
import com.Backend.music_app.repository.UserRepository;
import com.nimbusds.jose.*;
import com.nimbusds.jose.crypto.MACSigner;
import com.nimbusds.jose.crypto.MACVerifier;
import com.nimbusds.jwt.JWTClaimsSet;
import com.nimbusds.jwt.SignedJWT;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.experimental.NonFinal;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.text.ParseException;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class AuthenticationService {
    UserRepository userRepository;
    InvalidTokenReponsitory invalidTokenReponsitory;

    @NonFinal
    @Value("${jwt.signerKey}")
    protected String SIGN_KEY;


    @NonFinal
    @Value("${jwt.valid-duration}")
    protected long VALID_DURATION;

    @NonFinal
    @Value("${jwt.refreshable-duration}")
    protected long REFRESH_DURATION;


    public AuthenticationResponse authenticate(AuthenticationRequest request) {
        var user = userRepository.findUsersByEmail(request.getEmail()).orElseThrow(() -> new AppException(ErrorCode.USER_NOT_EXISTED));

        PasswordEncoder passwordEncoder = new BCryptPasswordEncoder(10);

        boolean authenticated = passwordEncoder.matches(request.getPassword(), user.getPasswordHash());
        if (!authenticated)
            throw new AppException(ErrorCode.UNAUTHENTICATED);

        var token = generateToken(user);

        return AuthenticationResponse.builder().token(token).authenticated(true).build();
    }


    private String generateToken(User users) {

        JWSHeader jwsHeader = new JWSHeader(JWSAlgorithm.HS512);

        JWTClaimsSet jwtClaimsSet = new JWTClaimsSet.Builder()
                .subject(users.getName()).issuer("devteria.com").issueTime(new Date()).expirationTime(new Date(
                        Instant.now().plus(VALID_DURATION, ChronoUnit.SECONDS).toEpochMilli()
                ))
                .jwtID(UUID.randomUUID().toString())
                .claim("scope", users.getRole()).build();

        Payload payload = new Payload(jwtClaimsSet.toJSONObject());

        JWSObject jwsObject = new JWSObject(jwsHeader, payload);

        try {
            jwsObject.sign(new MACSigner(SIGN_KEY.getBytes()));
            return jwsObject.serialize();
        } catch (JOSEException e) {
            log.error("Cannot create token", e);
            throw new RuntimeException(e);
        }

    }

    public IntrospectResponse introspect(IntrospectRequest request)
            throws JOSEException, ParseException {
        var token = request.getToken();
        boolean isValid = true;

        try {
            verifyToken(token, false);

        } catch (AppException exception) {
            isValid = false;

        }

        return IntrospectResponse.builder().valid(isValid).build();

    }


    public void logout(LogoutRequest request) throws JOSEException, ParseException {

        try
        {
            var signToken = verifyToken(request.getToken(), true);

            String jit = signToken.getJWTClaimsSet().getJWTID();
            Date expiryTime = signToken.getJWTClaimsSet().getExpirationTime();

            InvalidToken invalidToken = InvalidToken.builder()
                    .id(jit)
                    .expiryTime(expiryTime)
                    .build();

            invalidTokenReponsitory.save(invalidToken);

        }catch (Exception e)
        {
            log.info("Token already epired");
        }
    }


    public AuthenticationResponse refreshToken(RefreshRequest request)
            throws JOSEException, ParseException {
        var signIwt = verifyToken(request.getToken(), true);

        var jit = signIwt.getJWTClaimsSet().getJWTID();
        var expiryTime = signIwt.getJWTClaimsSet().getExpirationTime();

        InvalidToken invalidToken = InvalidToken.builder().id(jit).expiryTime(expiryTime).build();

        invalidTokenReponsitory.save(invalidToken);

        var userName = signIwt.getJWTClaimsSet().getSubject();

        var user = userRepository.findUsersByName(userName).orElseThrow(() -> new AppException(ErrorCode.UNAUTHENTICATED));

        var token = generateToken(user);

        return AuthenticationResponse.builder().token(token).authenticated(true).build();

    }

    private SignedJWT verifyToken(String token, boolean isRefresh) throws JOSEException, ParseException {

        JWSVerifier verifier = new MACVerifier(SIGN_KEY.getBytes());
        SignedJWT signedJWT = SignedJWT.parse(token);
        Date expiryTime = (isRefresh) ? new Date(signedJWT.getJWTClaimsSet().getIssueTime().toInstant().plus(REFRESH_DURATION, ChronoUnit.SECONDS).toEpochMilli())
        : signedJWT.getJWTClaimsSet().getExpirationTime();
        var verified = signedJWT.verify(verifier);

        if (!(verified && expiryTime.after(new Date()))) {
            throw new AppException(ErrorCode.UNAUTHENTICATED);
        }

        if (invalidTokenReponsitory.existsById(signedJWT.getJWTClaimsSet().getJWTID())) {
            throw new AppException(ErrorCode.UNAUTHENTICATED);
        }
        ;

        return signedJWT;
    }

}

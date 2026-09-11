package com.Backend.music_app.config;

import com.Backend.music_app.dto.request.IntrospectRequest;
import com.Backend.music_app.service.AuthenticationService;
import com.nimbusds.jose.JOSEException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.oauth2.jose.jws.MacAlgorithm;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.jwt.JwtDecoder;
import org.springframework.security.oauth2.jwt.JwtException;
import org.springframework.security.oauth2.jwt.NimbusJwtDecoder;

import javax.crypto.spec.SecretKeySpec;
import java.text.ParseException;
import java.util.Objects;

@Configuration
@EnableMethodSecurity
@EnableWebSecurity
public class CustomJwtDecode implements JwtDecoder{
    private final String[] PUBLIC_ENDPOINTS = {"/users/create/user", "auth/logout",
            "auth/token", "auth/introspect"
    };
    private final AuthenticationService authenticationService;

    @Value("${jwt.signerKey}")
    private String signerKey;
    private NimbusJwtDecoder nimbusJwtDecoder = null;

    public CustomJwtDecode(AuthenticationService authenticationService) {
        this.authenticationService = authenticationService;
    }

    @Override
    public Jwt decode(String token) throws JwtException {
        try
        {
            var result = authenticationService.introspect(IntrospectRequest.builder().token(token).build());

            if(!result.isValid())
            {
                throw new JwtException("invalid token");
            }
        }catch (JOSEException | ParseException e)
        {
            throw new JwtException(e.getMessage());
        }
        if(Objects.isNull(nimbusJwtDecoder))
        {
            SecretKeySpec secretKeySpec = new SecretKeySpec(signerKey.getBytes(), "");

            nimbusJwtDecoder = NimbusJwtDecoder.withSecretKey(secretKeySpec).macAlgorithm(MacAlgorithm.HS512).build();
        }

        return nimbusJwtDecoder.decode(token);
    }
}

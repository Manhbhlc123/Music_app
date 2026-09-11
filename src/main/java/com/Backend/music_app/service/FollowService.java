package com.Backend.music_app.service;

import com.Backend.music_app.dto.response.ArtistResponse;
import com.Backend.music_app.dto.response.Item.ArtistItemResponse;
import com.Backend.music_app.entity.Artist;
import com.Backend.music_app.entity.Follow;
import com.Backend.music_app.entity.User;
import com.Backend.music_app.exception.AppException;
import com.Backend.music_app.exception.ErrorCode;
import com.Backend.music_app.mapper.ArtistMapper;
import com.Backend.music_app.repository.ArtistRepository;
import com.Backend.music_app.repository.FollowReponsitory;
import com.Backend.music_app.repository.UserRepository;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class FollowService {
    FollowReponsitory followReponsitory;
    UserRepository userRepository;
    ArtistRepository artistRepository;
    ArtistMapper artistMapper;

    //lấy ds
    @Transactional(readOnly = true)
    public Page<ArtistItemResponse> getFollowedArtist(String userName, Pageable pageable)
    {
        User user = userRepository.findUsersByName(userName).orElseThrow(() -> new AppException(ErrorCode.USER_NOT_EXISTED));

        Page<Artist> artistPage = followReponsitory.findFollowedArtistByUserId(user.getId(), pageable);

        return artistPage.map(artistMapper::toArtistItemResponse);
    }

    //check
    @Transactional
    public boolean toggleFollow(String userName, UUID artistId)
    {
        User user = userRepository.findUsersByName(userName).orElseThrow(() -> new AppException(ErrorCode.USER_NOT_EXISTED));

        Artist artist = artistRepository.findArtistById(artistId);

        Optional<Follow> existingFollow = followReponsitory.findByUserIdAndArtistId(user.getId(), artistId);

        if(existingFollow.isPresent())
        {
            followReponsitory.delete(existingFollow.get());
            return false;
        }else {
            Follow newFollow = Follow.builder().user(user).artist(artist).build();
            followReponsitory.save(newFollow);
            return true;
        }
    }

    //check current state
    @Transactional(readOnly = true)
    public boolean checkState(String userName, UUID artistId)
    {
        User user = userRepository.findUsersByName(userName).orElseThrow(() -> new AppException(ErrorCode.USER_NOT_EXISTED));

        Artist artist = artistRepository.findArtistById(artistId);

        Optional<Follow> existingFollow = followReponsitory.findByUserIdAndArtistId(user.getId(), artistId);

        if(existingFollow.isPresent())
        {
            return true;
        }else {
            return false;
        }
    }
}

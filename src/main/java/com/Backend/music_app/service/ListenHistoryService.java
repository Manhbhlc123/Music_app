package com.Backend.music_app.service;

import com.Backend.music_app.dto.request.ListenHistoryRequest;
import com.Backend.music_app.dto.response.Item.ListenHistoryItemResponse;
import com.Backend.music_app.entity.ListenHistory;
import com.Backend.music_app.entity.Song;
import com.Backend.music_app.entity.User;
import com.Backend.music_app.exception.AppException;
import com.Backend.music_app.exception.ErrorCode;
import com.Backend.music_app.mapper.ListenHistoryMapper;
import com.Backend.music_app.repository.ListenHistoryRepository;
import com.Backend.music_app.repository.SongRepository;
import com.Backend.music_app.repository.UserRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class ListenHistoryService {
    ListenHistoryRepository listenHistoryRepository;
    ListenHistoryMapper listenHistoryMapper;
    UserRepository userRepository;
    SongRepository songRepository;


    @Transactional
    public ListenHistoryItemResponse createListenHistory(
            String userName,
            ListenHistoryRequest request
    ) {
        User user = userRepository.findUsersByName(userName)
                .orElseThrow(() ->
                        new AppException(ErrorCode.USER_NOT_EXISTED));

        Song song = songRepository.findById(request.getSongId())
                .orElseThrow(() ->
                        new AppException(ErrorCode.SONG_NOT_FOUND));

        ListenHistory history = ListenHistory.builder()
                .user(user)
                .song(song)
                .playDuration(request.getPlayDuration())
                .source(request.getSource())
                .build();

        ListenHistory savedHistory =
                listenHistoryRepository.save(history);

        return listenHistoryMapper.toListenHistoryResponse(savedHistory);
    }


    public List<ListenHistoryItemResponse> getList()
    {
        return listenHistoryRepository.findAll().stream().map(listenHistoryMapper::toListenHistoryResponse).toList();
    }

    @Transactional
    public void deleteSongOfHistoryListen(UUID id)
    {
        try{
            listenHistoryRepository.deleteById(id);
        }catch (Exception e)
        {
            throw new RuntimeException(e);
        }
    }
}

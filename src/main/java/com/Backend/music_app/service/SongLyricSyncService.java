package com.Backend.music_app.service;

import com.Backend.music_app.dto.request.LyricLineRequest;
import com.Backend.music_app.dto.response.SongLyricResponse;
import com.Backend.music_app.entity.Song;
import com.Backend.music_app.entity.SongLyricSync;
import com.Backend.music_app.exception.AppException;
import com.Backend.music_app.exception.ErrorCode;
import com.Backend.music_app.repository.SongLyricSyncRepository;
import com.Backend.music_app.repository.SongRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class SongLyricSyncService {
    SongLyricSyncRepository lyricRepository;
    SongRepository songRepository;

    // LẤY LỜI BÀI HÁT CHO NGƯỜI DÙNG
    @Transactional(readOnly = true)
    public SongLyricResponse getLyricsBySongId(UUID songId) {
        if (!songRepository.existsById(songId)) {
            throw new AppException(ErrorCode.SONG_NOT_FOUND);
        }

        List<SongLyricSync> lyricEntities = lyricRepository.findBySongIdOrderByLineOrderAsc(songId);

        List<LyricLineRequest> lineRequests = lyricEntities.stream()
                .map(entity -> LyricLineRequest.builder()
                        .timeStart(entity.getTimeStart())
                        .timeEnd(entity.getTimeEnd())
                        .lineText(entity.getLineText())
                        .lineOrder(entity.getLineOrder())
                        .build())
                .collect(Collectors.toList());

        return SongLyricResponse.builder()
                .songId(songId)
                .lyrics(lineRequests)
                .build();
    }

    // 2. LƯU HOẶC CẬP NHẬT LỜI BÀI HÁT (DÀNH CHO ADMIN)
    @Transactional
    @PreAuthorize("hasAuthority('Role_ADMIN')")
    public SongLyricResponse saveOrUpdateLyrics(UUID songId, List<LyricLineRequest> lines) {
        Song song = songRepository.findById(songId)
                .orElseThrow(() -> new AppException(ErrorCode.SONG_NOT_FOUND));

        // Xóa sạch lời cũ (nếu có) để tránh bị trùng lặp khi update
        lyricRepository.deleteAllBySongId(songId);

        // Map từ DTO sang Entity
        List<SongLyricSync> newLyrics = lines.stream()
                .map(line -> SongLyricSync.builder()
                        .song(song)
                        .timeStart(line.getTimeStart())
                        .timeEnd(line.getTimeEnd())
                        .lineText(line.getLineText())
                        .lineOrder(line.getLineOrder())
                        .build())
                .collect(Collectors.toList());

        // Lưu hàng loạt (Batch Insert)
        lyricRepository.saveAll(newLyrics);

        return getLyricsBySongId(songId); // Trả về kết quả mới nhất
    }

    // 3. XÓA LỜI BÀI HÁT
    @Transactional
    public void deleteLyrics(UUID songId) {
        lyricRepository.deleteAllBySongId(songId);
    }
}

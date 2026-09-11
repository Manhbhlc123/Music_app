package com.Backend.music_app.service;

import com.Backend.music_app.dto.request.DownloadRequest;
import com.Backend.music_app.dto.response.DownloadResponse;
import com.Backend.music_app.entity.Download;
import com.Backend.music_app.entity.Song;
import com.Backend.music_app.entity.User;
import com.Backend.music_app.exception.AppException;
import com.Backend.music_app.exception.ErrorCode;
import com.Backend.music_app.mapper.DownloadMapper;
import com.Backend.music_app.repository.DownloadRepository;
import com.Backend.music_app.repository.SongRepository;
import com.Backend.music_app.repository.UserRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.time.YearMonth;
import java.util.UUID;

@Service
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RequiredArgsConstructor
@Slf4j
public class DownloadService {
    DownloadRepository downloadRepository;
    UserRepository userRepository;
    SongRepository songRepository;
    DownloadMapper downloadMapper;

    static final int MAX_FREE_DOWNLOADS_PER_MONTH = 10;

    @Transactional
    public DownloadResponse processDownload(String userName, DownloadRequest request) {
        User user = userRepository.findUsersByName(userName).orElseThrow(() -> new AppException(ErrorCode.USER_NOT_EXISTED));

        Song song = songRepository.findById(request.getSongId()).orElseThrow(() -> new AppException(ErrorCode.SONG_NOT_FOUND));

        String requestedQuality = request.getQuality() != null ? request.getQuality().toLowerCase() : "normal";

        if ("hq".equals(requestedQuality) && !Boolean.TRUE.equals(user.isVip())) {
            throw new RuntimeException("Chất lượng nhạc HQ chỉ dành cho tài khoản VIP. Vui lòng nâng cấp!");
        }

        String currentMonthKey = YearMonth.now().toString();

        long currentMonthDownloads = downloadRepository.countByUserIdAndMonthKey(user.getId(), currentMonthKey);

        if (!Boolean.TRUE.equals(user.isVip()) && currentMonthDownloads >= MAX_FREE_DOWNLOADS_PER_MONTH) {
            throw new RuntimeException("Bạn đã dùng hết" + MAX_FREE_DOWNLOADS_PER_MONTH + " Lượt tải nhạc miễn phí của tháng này" + currentMonthKey + " hãy nâng cấp VIP để tải không giới hạn");
        }

        String finalAudioUrl = "hq".equals(requestedQuality) && song.getAudioUrlHq() != null
                ? song.getAudioUrlHq()
                : song.getAudioUrlNormal();

        Download download = Download.builder().user(user).song(song).quality(requestedQuality).fileLocalPath(request.getFileLocalPath()).monthKey(currentMonthKey).build();
        Download savedDownload = downloadRepository.save(download);

        long remaining = Boolean.TRUE.equals(user.isVip())
                ? -1
                : Math.max(0, MAX_FREE_DOWNLOADS_PER_MONTH - (currentMonthDownloads + 1));

        return DownloadResponse.builder().downloadId(savedDownload.getId()).songId(song.getId()).songTitle(song.getTitle()).downloadUrl(finalAudioUrl).quality(requestedQuality).remainingDownloadThisMonth(remaining).downloadedAt(LocalDateTime.now()).build();
    }

    @Transactional
    public Page<DownloadResponse>  getUserDownloadHistory(String userName, Pageable pageable)
    {
        Page<Download> downloadPage = downloadRepository.findByUser_NameOrderByDownloadedAtDesc(userName, pageable);
        return downloadPage.map(download -> downloadMapper.toDownloadResponse(download));
    }


    @Transactional(readOnly = true)
    public long getDownloadCount(String userName)
    {
        User user = userRepository.findUsersByName(userName).orElseThrow(() -> new AppException(ErrorCode.USER_NOT_EXISTED));

        if(Boolean.TRUE.equals(user.isVip()))
        {
           return -1L;
        }

        String currentMonthKey = YearMonth.now().toString();

        long curentMonthDownloads = downloadRepository.countByUserIdAndMonthKey(user.getId(), currentMonthKey);

        return Math.max(0, MAX_FREE_DOWNLOADS_PER_MONTH - curentMonthDownloads);
    }
}

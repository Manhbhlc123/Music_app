package com.Backend.music_app.repository;

import com.Backend.music_app.dto.response.DownloadResponse;
import com.Backend.music_app.entity.Download;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface DownloadRepository extends JpaRepository<Download, UUID> {
    long countByUserIdAndMonthKey(UUID userId, String monthKey);
    Page<Download> findByUser_NameOrderByDownloadedAtDesc(String username, Pageable pageable);
    UUID userId(UUID userId);
}

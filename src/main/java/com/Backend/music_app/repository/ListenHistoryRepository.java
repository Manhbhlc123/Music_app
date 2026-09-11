package com.Backend.music_app.repository;

import com.Backend.music_app.entity.ListenHistory;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface ListenHistoryRepository extends JpaRepository<ListenHistory, UUID> {
}

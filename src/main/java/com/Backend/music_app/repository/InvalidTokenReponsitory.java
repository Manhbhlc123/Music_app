package com.Backend.music_app.repository;

import com.Backend.music_app.entity.InvalidToken;
import org.springframework.data.jpa.repository.JpaRepository;

public interface InvalidTokenReponsitory extends JpaRepository<InvalidToken, String> {
}

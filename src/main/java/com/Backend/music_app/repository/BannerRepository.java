package com.Backend.music_app.repository;

import com.Backend.music_app.entity.Banner;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface BannerRepository extends JpaRepository<Banner, UUID> {
    boolean existsBannerById(UUID id);

    boolean existsBannerByTitle(String title);
}

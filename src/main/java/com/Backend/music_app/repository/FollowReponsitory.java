package com.Backend.music_app.repository;

import com.Backend.music_app.dto.response.ArtistResponse;
import com.Backend.music_app.entity.Artist;
import com.Backend.music_app.entity.Follow;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface FollowReponsitory extends JpaRepository<Follow, UUID> {

    //lấy ds artist mà user đã theo dõi
    @Query("""
            select f.artist from Follow f
            where f.user.id =  :userId
            order by f.createdAt DESC
""")
    Page<Artist> findFollowedArtistByUserId(@Param("userId") UUID userId, Pageable pageable);

    //kiểm tra user đã theo dõi artist
    boolean existsByUserIdAndArtistId(UUID userId, UUID artistId);

    //UnFollow
    Optional<Follow> findByUserIdAndArtistId(UUID userId, UUID artistId);
}

package com.Backend.music_app.service;

import com.Backend.music_app.dto.request.SearchHistoryCreateRequest;
import com.Backend.music_app.dto.response.Item.*;
import com.Backend.music_app.dto.response.Item.SearchResponse;
import com.Backend.music_app.dto.response.SearchHistoryResponse;
import com.Backend.music_app.dto.response.TrendingKeywordResponse;
import com.Backend.music_app.entity.*;
import com.Backend.music_app.exception.AppException;
import com.Backend.music_app.exception.ErrorCode;
import com.Backend.music_app.mapper.*;
import com.Backend.music_app.repository.*;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Locale;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class SearchHistoryService {
    UserRepository userRepository;
    SongRepository songRepository;
    ArtistRepository artistRepository;
    AlbumRepositoty albumRepository;
    PlaylistRepisitory playlistRepository;
    SearchHistoryRepository searchHistoryRepository;
    TrendingKeywordRepository trendingKeywordRepository;

    SearchHistoryMapper searchHistoryMapper;
    TrendingKeywordMapper trendingKeywordMapper;
    SongMapper songMapper;
    ArtistMapper artistMapper;
    AlbumMapper albumMapper;
    PlaylistMapper playlistMapper;


    @Transactional
    public SearchHistoryResponse create(String userName, SearchHistoryCreateRequest request) {
        User user = userRepository.findUsersByName(userName).orElseThrow(() -> new AppException(ErrorCode.USER_NOT_EXISTED));

        String cleanKeyword = normalizeKeyword(request.getKeyword());

        searchHistoryRepository.deleteByUserAndKeyword(user, cleanKeyword);

        SearchHistory searchHistory = SearchHistory.builder().user(user)
                .keyword(cleanKeyword)
                .resultType(null)
                .clickedResultId(null)
                .build();

        return searchHistoryMapper.toSearchHistoryRespose(searchHistoryRepository.save(searchHistory));
    }

    @Transactional(readOnly = true)
    public List<SearchHistoryResponse> getHistory(String userName) {
        // Thống nhất dùng findUsersByEmail (hoặc hàm chuẩn trong hệ thống của bạn)
        User user = userRepository.findUsersByName(userName)
                .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_EXISTED));

        return searchHistoryRepository.findTop10ByUserOrderBySearchedAtDesc(user)
                .stream()
                .map(searchHistoryMapper::toSearchHistoryRespose)
                .toList();
    }

    @Transactional
    public SearchResponse search(String keyword, String userName, int page, int size) {
        String cleanKeyword = keyword.trim();


        Pageable pageable = PageRequest.of(page, size);

        List<SongItemResponse> songs = songRepository.search(cleanKeyword, pageable).stream().map(songMapper::toSongItemResponse).toList();
        List<ArtistItemResponse> artists = artistRepository.search(cleanKeyword, pageable).stream().map(artistMapper::toArtistItemResponse).toList();
        List<AlbumItemResponse> albums = albumRepository.search(cleanKeyword, pageable).stream().map(albumMapper::toAlbumItemResponse).toList();
        List<PlaylistItemResponse> playlists = playlistRepository.search(cleanKeyword, pageable).stream().map(playlistMapper::toPlaylistItemResponse).toList();


        // 1. Lưu lịch sử tìm kiếm cho User
        saveHistory(cleanKeyword, userName);

        // 2. Cập nhật từ khóa thịnh hành (dùng từ khóa đã chuẩn hóa chữ thường)
        updateTrendingKeyword(normalizeKeyword(cleanKeyword));

        return SearchResponse.builder()
                .songs(songs)
                .albums(albums)
                .artists(artists)
                .playlists(playlists)
                .build();
    }

    private void saveHistory(String keyword, String userName) {
        User user = userRepository.findUsersByName(userName)
                .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_EXISTED));

        SearchHistory history = SearchHistory.builder()
                .user(user)
                .keyword(keyword)
                .searchedAt(LocalDateTime.now())
                .build();

        searchHistoryRepository.save(history);
    }

    private void updateTrendingKeyword(String normalizedKeyword) {
        Optional<TrendingKeyword> optionalTrendingKeyword = trendingKeywordRepository.findByKeywordIgnoreCase(normalizedKeyword);

        if (optionalTrendingKeyword.isPresent()) {
            TrendingKeyword trendingKeyword = optionalTrendingKeyword.get();
            trendingKeyword.setSearchCount(trendingKeyword.getSearchCount() + 1);
            trendingKeyword.setLastSearchedAt(LocalDateTime.now());
            trendingKeyword.setUpdatedAt(LocalDateTime.now());
            trendingKeywordRepository.save(trendingKeyword);
        } else {
            TrendingKeyword trendingKeyword = TrendingKeyword.builder()
                    .keyword(normalizedKeyword)
                    .searchCount(1L)
                    .lastSearchedAt(LocalDateTime.now())
                    .updatedAt(LocalDateTime.now())
                    .build();
            trendingKeywordRepository.save(trendingKeyword);
        }
    }

    @Transactional
    public void clearHistory(String userName) {
        User user = userRepository.findUsersByName(userName).orElseThrow(() -> new AppException(ErrorCode.USER_NOT_EXISTED));

        searchHistoryRepository.deleteByUser(user);
    }

    @Transactional(readOnly = true)
    public List<TrendingKeywordResponse> getTrending() {
        return trendingKeywordRepository.findTop10ByOrderBySearchCountDesc()
                .stream()
                .map(trendingKeywordMapper::toResponse)
                .toList();
    }

    private String normalizeKeyword(String keyword) {
        return keyword.trim().toLowerCase(Locale.ROOT);
    }


}
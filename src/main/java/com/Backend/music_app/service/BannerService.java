package com.Backend.music_app.service;

import com.Backend.music_app.dto.request.BannerCreateRequest;
import com.Backend.music_app.dto.response.BannerResponse;
import com.Backend.music_app.exception.AppException;
import com.Backend.music_app.exception.ErrorCode;
import com.Backend.music_app.mapper.BannerMapper;
import com.Backend.music_app.repository.BannerRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class BannerService {
    final BannerRepository bannerRepository;
    final BannerMapper bannerMapper;

    @Transactional
    @PreAuthorize("hasAuthority('Role_ADMIN')")
    public BannerResponse createBanner(BannerCreateRequest request) {
        if (bannerRepository.existsBannerByTitle((request.getTitle()))) {
            throw new AppException(ErrorCode.BANNER_EXISTED);
        }
        var banner = bannerMapper.toBanner(request);
        return bannerMapper.toBannerResponse(bannerRepository.save(banner));
    }

    @Transactional
    public List<BannerResponse> getALLBanner() {
        return bannerRepository.findAll().stream().map(bannerMapper::toBannerResponse).toList();
    }

    @Transactional
    public void deleteBanner(UUID id)
    {
        try
        {
            bannerRepository.deleteById(id);
        }catch (Exception e)
        {
            throw new RuntimeException(e);
        }
    }
}

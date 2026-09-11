package com.Backend.music_app.mapper;

import com.Backend.music_app.dto.request.DownloadRequest;
import com.Backend.music_app.dto.response.DownloadResponse;
import com.Backend.music_app.entity.Download;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface DownloadMapper {
    Download toDownload(DownloadRequest request);

    DownloadResponse toDownloadResponse(Download download);
}

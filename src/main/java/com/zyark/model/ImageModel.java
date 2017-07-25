package com.zyark.model;

import org.springframework.web.multipart.MultipartFile;

/**
 * Created by ron on 17-4-12.
 */
public class ImageModel {
    private MultipartFile[] images;

    public MultipartFile[] getImages() {
        return images;
    }

    public void setImages(MultipartFile[] images) {
        this.images = images;
    }
}

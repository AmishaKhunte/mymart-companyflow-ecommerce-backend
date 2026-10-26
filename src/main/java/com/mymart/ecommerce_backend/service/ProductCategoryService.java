package com.mymart.ecommerce_backend.service;

import com.mymart.ecommerce_backend.dto.ProductCategoryDto;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface ProductCategoryService {

    ProductCategoryDto createProductCategory(
            ProductCategoryDto productCategoryDto,
            MultipartFile image
    );

    List<ProductCategoryDto> getAllProductCategories();

    ProductCategoryDto getProductCategoryById(
            Integer categoryId
    );

    ProductCategoryDto updateProductCategory(
            Integer categoryId,
            ProductCategoryDto productCategoryDto,
            MultipartFile image
    );

    ProductCategoryDto deleteProductCategory(
            Integer categoryId
    );
}
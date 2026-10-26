
package com.mymart.ecommerce_backend.service.Imp;

import com.mymart.ecommerce_backend.constants.AppConstants;
import com.mymart.ecommerce_backend.dto.ProductCategoryDto;
import com.mymart.ecommerce_backend.entities.ProductCategoryEntity;
import com.mymart.ecommerce_backend.mapper.ProductCategoryMapper;
import com.mymart.ecommerce_backend.repos.ProductCategoryRepo;
import com.mymart.ecommerce_backend.service.ProductCategoryService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class ProductCategoryServiceImp implements ProductCategoryService {

    @Autowired
    private ProductCategoryRepo productCategoryRepo;

    @Value("${app.images.upload-dir}")
    private String uploadDir;

    // CREATE CATEGORY
    @Override
    public ProductCategoryDto createProductCategory(
            ProductCategoryDto productCategoryDto,
            MultipartFile image) {

        productCategoryDto.setActiveSw(AppConstants.YES);

        try {
            if (image != null && !image.isEmpty()) {
                String imageFileName = saveImage(image);
                productCategoryDto.setCategoryImage(imageFileName);
            }

            ProductCategoryEntity productCategoryEntity =
                    new ProductCategoryEntity();

            productCategoryEntity.setCategoryName(
                    productCategoryDto.getCategoryName()
            );

            productCategoryEntity.setCategoryDescription(
                    productCategoryDto.getCategoryDescription()
            );

            productCategoryEntity.setCategoryImage(
                    productCategoryDto.getCategoryImage()
            );

            productCategoryEntity.setActiveSw(
                    productCategoryDto.getActiveSw()
            );

            productCategoryEntity.setCreatedBy(
                    toInteger(productCategoryDto.getCreatedBy())
            );

            productCategoryEntity.setUpdatedBy(
                    toInteger(productCategoryDto.getUpdatedBy())
            );

            ProductCategoryEntity savedEntity =
                    productCategoryRepo.save(productCategoryEntity);

            return ProductCategoryMapper.toDto(savedEntity);

        } catch (Exception e) {
            throw new RuntimeException(
                    "Failed to save product category",
                    e
            );
        }
    }

    // GET ALL CATEGORIES
    @Override
    public List<ProductCategoryDto> getAllProductCategories() {

        List<ProductCategoryEntity> entities =
                productCategoryRepo.findAll();

        return entities.stream()
                .map(ProductCategoryMapper::toDto)
                .collect(Collectors.toList());
    }

    // GET CATEGORY BY ID
    @Override
    public ProductCategoryDto getProductCategoryById(
            Integer categoryId) {

        ProductCategoryEntity productCategoryEntity =
                productCategoryRepo.findById(categoryId)
                        .orElseThrow(() ->
                                new RuntimeException(
                                        "Product category not found with id: "
                                                + categoryId
                                )
                        );

        return ProductCategoryMapper.toDto(productCategoryEntity);
    }

    // GET CATEGORY BY NAME
    public ProductCategoryDto getProductCategoryByName(
            String categoryName) {

        ProductCategoryEntity productCategoryEntity =
                productCategoryRepo.findByCategoryName(categoryName);

        if (productCategoryEntity != null) {
            return ProductCategoryMapper.toDto(
                    productCategoryEntity
            );
        }

        return null;
    }

    // UPDATE CATEGORY AND OPTIONAL IMAGE
    @Override
    public ProductCategoryDto updateProductCategory(
            Integer categoryId,
            ProductCategoryDto productCategoryDto,
            MultipartFile image) {

        ProductCategoryEntity existingEntity =
                productCategoryRepo.findById(categoryId)
                        .orElseThrow(() ->
                                new RuntimeException(
                                        "Product category not found with id: "
                                                + categoryId
                                )
                        );

        try {
            // Update category name
            if (productCategoryDto.getCategoryName() != null
                    && !productCategoryDto.getCategoryName().isBlank()) {

                existingEntity.setCategoryName(
                        productCategoryDto.getCategoryName()
                );
            }

            // Update description when supplied
            if (productCategoryDto.getCategoryDescription() != null) {
                existingEntity.setCategoryDescription(
                        productCategoryDto.getCategoryDescription()
                );
            }

            // Preserve the current status unless a new status is supplied
            if (productCategoryDto.getActiveSw() != null) {
                existingEntity.setActiveSw(
                        productCategoryDto.getActiveSw()
                );
            }

            // Update modifier when supplied
            if (productCategoryDto.getUpdatedBy() != null) {
                existingEntity.setUpdatedBy(
                        toInteger(productCategoryDto.getUpdatedBy())
                );
            }

            // Replace image only when a new image is uploaded
            if (image != null && !image.isEmpty()) {
                String imageFileName = saveImage(image);

                existingEntity.setCategoryImage(imageFileName);
            }

            ProductCategoryEntity updatedEntity =
                    productCategoryRepo.save(existingEntity);

            return ProductCategoryMapper.toDto(updatedEntity);

        } catch (Exception e) {
            throw new RuntimeException(
                    "Failed to update product category",
                    e
            );
        }
    }

    // SOFT DELETE CATEGORY
    @Override
    public ProductCategoryDto deleteProductCategory(
            Integer categoryId) {

        ProductCategoryEntity existingEntity =
                productCategoryRepo.findById(categoryId)
                        .orElseThrow(() ->
                                new RuntimeException(
                                        "Product category not found with id: "
                                                + categoryId
                                )
                        );

        existingEntity.setActiveSw(AppConstants.NO);

        ProductCategoryEntity updatedEntity =
                productCategoryRepo.save(existingEntity);

        return ProductCategoryMapper.toDto(updatedEntity);
    }

    // SAVE IMAGE TO CONFIGURED UPLOAD DIRECTORY
    private String saveImage(MultipartFile image) throws Exception {

        String originalFileName = image.getOriginalFilename();
        String extension = "";

        if (originalFileName != null
                && originalFileName.contains(".")) {

            extension = originalFileName.substring(
                    originalFileName.lastIndexOf(".")
            );
        }

        String imageFileName = UUID.randomUUID() + extension;

        Path uploadPath = Paths.get(uploadDir);
        Files.createDirectories(uploadPath);

        Path imagePath = uploadPath.resolve(imageFileName).normalize();

        // Prevent a path from escaping the configured upload directory
        if (!imagePath.startsWith(uploadPath.toAbsolutePath().normalize())
                && uploadPath.isAbsolute()) {
            throw new IllegalArgumentException("Invalid image path");
        }

        Files.copy(image.getInputStream(), imagePath);

        return imageFileName;
    }

    // CONVERT STRING ID TO INTEGER
    private Integer toInteger(String value) {

        if (value == null || value.isBlank()) {
            return null;
        }

        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException ex) {
            return null;
        }
    }
}

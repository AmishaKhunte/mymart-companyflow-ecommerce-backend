package com.mymart.ecommerce_backend.controller;

import com.mymart.ecommerce_backend.dto.ApiResponse;
import com.mymart.ecommerce_backend.dto.ProductCategoryDto;
import com.mymart.ecommerce_backend.service.ProductCategoryService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RestController
@RequestMapping("/api/admin")
public class ProductCategoryController {

    @Autowired
    private ProductCategoryService productCategoryService;


    // ============================
    // CREATE PRODUCT CATEGORY
    // ============================

    @PostMapping(
            value = "/product-category",
            consumes = "multipart/form-data"
    )
    public ResponseEntity<ApiResponse<ProductCategoryDto>> createProductCategory(

            @RequestParam("categoryName")
            String categoryName,

            @RequestParam(value = "categoryDescription", required = false)
            String categoryDescription,

            @RequestParam("image")
            MultipartFile image
    ) {

        ProductCategoryDto productCategoryDto =
                new ProductCategoryDto();

        productCategoryDto.setCategoryName(categoryName);
        productCategoryDto.setCategoryDescription(categoryDescription);

        ProductCategoryDto productCategory =
                productCategoryService.createProductCategory(
                        productCategoryDto,
                        image
                );

        ApiResponse<ProductCategoryDto> response =
                new ApiResponse<>();

        if (productCategory != null) {

            response.setStatusCode(201);
            response.setData(productCategory);
            response.setMessage("Product Category Saved");

            return ResponseEntity
                    .status(HttpStatus.CREATED)
                    .body(response);

        } else {

            response.setStatusCode(500);
            response.setMessage("Product Category Saved Failed");
            response.setData(null);

            return ResponseEntity
                    .status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(response);
        }
    }


    // ============================
    // GET ALL PRODUCT CATEGORIES
    // ============================

    @GetMapping("/product-categories")
    public ResponseEntity<ApiResponse<List<ProductCategoryDto>>>
    getAllProductCategories() {

        List<ProductCategoryDto> allProductCategories =
                productCategoryService.getAllProductCategories();

        ApiResponse<List<ProductCategoryDto>> response =
                new ApiResponse<>();

        response.setStatusCode(200);
        response.setMessage(
                "Product Categories Retrieved Successfully"
        );
        response.setData(allProductCategories);

        return ResponseEntity.ok(response);
    }


    // ============================
    // GET CATEGORY BY ID
    // ============================

    @GetMapping("/product-category/{categoryId}")
    public ResponseEntity<ApiResponse<ProductCategoryDto>>
    getProductCategoryById(
            @PathVariable Integer categoryId
    ) {

        ProductCategoryDto productCategoryById =
                productCategoryService.getProductCategoryById(
                        categoryId
                );

        ApiResponse<ProductCategoryDto> response =
                new ApiResponse<>();

        response.setStatusCode(200);
        response.setMessage("Product Category Retrieved");
        response.setData(productCategoryById);

        return ResponseEntity.ok(response);
    }


    // ============================
    // UPDATE CATEGORY
    // ============================


    @PutMapping(
            value = "/product-category/{categoryId}",
            consumes = MediaType.MULTIPART_FORM_DATA_VALUE
    )
    public ResponseEntity<ApiResponse<ProductCategoryDto>> updateCategory(
            @PathVariable Integer categoryId,
            @RequestParam("categoryName") String categoryName,
            @RequestParam(value = "categoryDescription", required = false)
            String categoryDescription,
            @RequestParam(value = "image", required = false)
            MultipartFile image
    ) {
        ProductCategoryDto categoryDto = new ProductCategoryDto();

        categoryDto.setCategoryName(categoryName);
        categoryDto.setCategoryDescription(categoryDescription);

        ProductCategoryDto updatedCategory =
                productCategoryService.updateProductCategory(
                        categoryId,
                        categoryDto,
                        image
                );

        ApiResponse<ProductCategoryDto> response = new ApiResponse<>();
        response.setStatusCode(200);
        response.setMessage("Product Category Updated");
        response.setData(updatedCategory);

        return ResponseEntity.ok(response);
    }


    // ============================
    // DELETE CATEGORY
    // ============================

    @DeleteMapping("/product-category/{categoryId}")
    public ResponseEntity<ApiResponse<ProductCategoryDto>>
    deleteCategory(
            @PathVariable Integer categoryId
    ) {

        ProductCategoryDto deletedCategory =
                productCategoryService.deleteProductCategory(
                        categoryId
                );

        ApiResponse<ProductCategoryDto> response =
                new ApiResponse<>();

        response.setStatusCode(200);
        response.setMessage("Product Category Deleted");
        response.setData(deletedCategory);

        return ResponseEntity.ok(response);
    }
}
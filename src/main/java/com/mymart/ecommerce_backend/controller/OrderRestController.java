package com.mymart.ecommerce_backend.controller;


import com.mymart.ecommerce_backend.dto.ApiResponse;
import com.mymart.ecommerce_backend.dto.OrderDto;
import com.mymart.ecommerce_backend.dto.PurchaseOrderRequestDto;
import com.mymart.ecommerce_backend.dto.PurchaseOrderResponseDto;
import com.mymart.ecommerce_backend.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/order")
public class OrderRestController {

    @Autowired
    private OrderService orderService;

    @PostMapping("/create")
    public ResponseEntity<ApiResponse<PurchaseOrderResponseDto>> createOrder(@RequestBody PurchaseOrderRequestDto purchaseOrder) throws Exception{

        PurchaseOrderResponseDto orderResponseDto = orderService.createOrder(purchaseOrder);

        ApiResponse<PurchaseOrderResponseDto> response = new ApiResponse<>();
        if (orderResponseDto != null) {
            response.setStatusCode(201);
            response.setMessage("Order Placed Successfully");
            response.setData(orderResponseDto);
            return new ResponseEntity<>(response, HttpStatus.CREATED);
        } else {
            response.setStatusCode(500);
            response.setMessage("Failed to create Order");
            response.setData(null);
            return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PutMapping("/update/{orderId}")
    public ResponseEntity<ApiResponse<OrderDto>> updateOrder(@PathVariable Integer orderId, @RequestBody OrderDto orderDto){

        OrderDto updatedOrder = orderService.updateOrder(orderId, orderDto);

        ApiResponse<OrderDto> response = new ApiResponse<>();
        if (updatedOrder != null) {
            response.setStatusCode(200);
            response.setMessage("Order Updated Successfully");
            response.setData(updatedOrder);
            return new ResponseEntity<>(response, HttpStatus.OK);
        } else {
            response.setStatusCode(500);
            response.setMessage("Failed to update Order");
            response.setData(updatedOrder);
            return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
        }

    }

    @PutMapping("/cancel/{orderId}")
    public ResponseEntity<ApiResponse<OrderDto>> cancelOrder(@PathVariable Integer orderId) throws Exception{

        OrderDto cancelledOrder = orderService.cancelOrder(orderId);

        ApiResponse<OrderDto> response = new ApiResponse<>();
        if (cancelledOrder != null) {
            response.setStatusCode(200);
            response.setMessage("Order Cancelled Successfully");
            response.setData(cancelledOrder);
            return new ResponseEntity<>(response, HttpStatus.OK);
        } else {
            response.setStatusCode(500);
            response.setMessage("Failed to cancel Order");
            response.setData(cancelledOrder);
            return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("/customer/{email}")
    public ResponseEntity<ApiResponse<List<OrderDto>>> getCustomerOrders(@PathVariable String email){
        ApiResponse<List<OrderDto>> response = new ApiResponse<>();

        List<OrderDto> customerOrders = orderService.getCustomerOrders(email);

        if(!customerOrders.isEmpty()){
            response.setStatusCode(200);
            response.setMessage("Orders fetched successfully");
            response.setData(customerOrders);
            return new ResponseEntity<>(response, HttpStatus.OK);
        }else{
            response.setStatusCode(200);
            response.setMessage("No Orders Found");
            response.setData(Collections.emptyList());
            return new ResponseEntity<>(response, HttpStatus.OK);
        }
    }


    @PostMapping("/verify-payment")
    public ResponseEntity<ApiResponse<Boolean>> verifyPayment(
            @RequestBody Map<String, String> paymentDetails
    ) throws Exception {

        Integer orderId = Integer.valueOf(paymentDetails.get("orderId"));

        String razorpayOrderId = paymentDetails.get("razorpay_order_id");
        String razorpayPaymentId = paymentDetails.get("razorpay_payment_id");
        String razorpaySignature = paymentDetails.get("razorpay_signature");

        boolean verified = orderService.verifyPayment(
                orderId,
                razorpayOrderId,
                razorpayPaymentId,
                razorpaySignature
        );

        ApiResponse<Boolean> response = new ApiResponse<>();

        if (verified) {
            response.setStatusCode(200);
            response.setMessage("Payment verified successfully");
            response.setData(true);
            return ResponseEntity.ok(response);
        }

        response.setStatusCode(400);
        response.setMessage("Payment verification failed");
        response.setData(false);

        return ResponseEntity.badRequest().body(response);
    }


}

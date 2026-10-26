
package com.mymart.ecommerce_backend.service;

import com.mymart.ecommerce_backend.dto.OrderDto;
import com.mymart.ecommerce_backend.dto.PurchaseOrderRequestDto;
import com.mymart.ecommerce_backend.dto.PurchaseOrderResponseDto;

import java.util.List;

public interface OrderService {

    PurchaseOrderResponseDto createOrder(
            PurchaseOrderRequestDto orderReqDto
    ) throws Exception;

    OrderDto updateOrder(Integer orderId, OrderDto orderDto);

    OrderDto cancelOrder(Integer orderId) throws Exception;

    OrderDto trackOrder(Integer orderId);

    List<OrderDto> getCustomerOrders(String email);

    boolean verifyPayment(
            Integer orderId,
            String razorpayOrderId,
            String razorpayPaymentId,
            String razorpaySignature
    ) throws Exception;
}

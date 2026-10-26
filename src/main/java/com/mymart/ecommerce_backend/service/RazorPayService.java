package com.mymart.ecommerce_backend.service;

public interface RazorPayService {




        String createRazorpayOrder(Double amount) throws Exception;

        String refundPayment(String paymentId, Double amount) throws Exception;

        boolean verifyPaymentSignature(
                String razorpayOrderId,
                String razorpayPaymentId,
                String razorpaySignature
        ) throws Exception;
    }



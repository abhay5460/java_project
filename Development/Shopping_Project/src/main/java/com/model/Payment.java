package com.model;

import java.time.LocalDate;

public class Payment {
    private int Payment_id;
    private int Order_id;
    private String Payment_Method;
    private int Payment_amount;
    private LocalDate Payment_date; // Change to LocalDate
    private String Payment_status;
    private int Transaction_id;

    public int getPayment_id() {
        return Payment_id;
    }

    public void setPayment_id(int payment_id) {
        Payment_id = payment_id;
    }

    public int getOrder_id() {
        return Order_id;
    }

    public void setOrder_id(int order_id) {
        Order_id = order_id;
    }

    public String getPayment_Method() {
        return Payment_Method;
    }

    public void setPayment_Method(String payment_Method) {
        Payment_Method = payment_Method;
    }

    public int getPayment_amount() {
        return Payment_amount;
    }

    public void setPayment_amount(int payment_amount) {
        Payment_amount = payment_amount;
    }

    public LocalDate getPayment_date() { // Change return type to LocalDate
        return Payment_date;
    }

    public void setPayment_date(LocalDate payment_date) { // Change parameter type to LocalDate
        Payment_date = payment_date;
    }

    public String getPayment_status() {
        return Payment_status;
    }

    public void setPayment_status(String payment_status) {
        Payment_status = payment_status;
    }

    public int getTransaction_id() {
        return Transaction_id;
    }

    public void setTransaction_id(int transaction_id) {
        Transaction_id = transaction_id;
    }
}
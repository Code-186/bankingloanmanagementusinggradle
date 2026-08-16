package com.crimsonlogic.bankingloanmanagementsystem.controller;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.CustomerNotFoundException;
import com.crimsonlogic.bankingloanmanagementsystem.service.interfaces.ICustomerService;
import com.crimsonlogic.bankingloanmanagementsystem.userimplementation.Customer;
import com.crimsonlogic.bankingloanmanagementsystem.utility.ValidationUtil;

@Controller
@RequestMapping("/customer")
public class CustomerController {

    @Autowired
    private ICustomerService customerService;

    private boolean isCustomer(HttpSession session) {
        return "CUSTOMER".equals(session.getAttribute("userRole"));
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        if (!isCustomer(session)) return "redirect:/login?role=CUSTOMER";
        Customer customer = (Customer) session.getAttribute("loggedInUser");
        model.addAttribute("customer", customer);
        return "customer/customer-dashboard";
    }

    @GetMapping("/profile")
    public String viewProfile(HttpSession session, Model model) {
        if (!isCustomer(session)) return "redirect:/login?role=CUSTOMER";
        Customer customer = (Customer) session.getAttribute("loggedInUser");
        try {
            model.addAttribute("customer", customerService.getProfile(customer.getCustomerId()));
        } catch (CustomerNotFoundException e) {
            model.addAttribute("error", e.getMessage());
        }
        return "customer/profile";
    }

    @PostMapping("/profile/update")
    public String updateProfile(
            @RequestParam("phoneNumber") String phone,
            @RequestParam("address") String address,
            @RequestParam("nomineeName") String nomineeName,
            @RequestParam("nomineeRelationship") String nomineeRelationship,
            @RequestParam("nomineePhoneNumber") String nomineePhone,
            HttpSession session, Model model) {

        if (!isCustomer(session)) return "redirect:/login?role=CUSTOMER";
        Customer customer = (Customer) session.getAttribute("loggedInUser");

        customer.setPhoneNumber(phone);
        customer.setAddress(address);
        customer.setNomineeName(nomineeName);
        customer.setNomineeRelationship(nomineeRelationship);
        customer.setNomineePhoneNumber(nomineePhone);

        customerService.updateProfile(customer);
        model.addAttribute("message", "Profile updated successfully.");
        model.addAttribute("customer", customer);
        return "customer/profile";
    }

    @PostMapping("/profile/change-password")
    public String changePassword(
            @RequestParam("oldPassword") String oldPassword,
            @RequestParam("newPassword") String newPassword,
            HttpSession session, Model model) {

        if (!isCustomer(session)) return "redirect:/login?role=CUSTOMER";
        Customer customer = (Customer) session.getAttribute("loggedInUser");

        if (!ValidationUtil.validatePassword(newPassword)) {
            model.addAttribute("error", "New password does not meet security requirements.");
            model.addAttribute("customer", customer);
            return "customer/profile";
        }

        if (customerService.changePassword(customer.getCustomerId(), oldPassword, newPassword)) {
            model.addAttribute("message", "Password changed successfully.");
        } else {
            model.addAttribute("error", "Incorrect current password entered.");
        }
        model.addAttribute("customer", customer);
        return "customer/profile";
    }
}
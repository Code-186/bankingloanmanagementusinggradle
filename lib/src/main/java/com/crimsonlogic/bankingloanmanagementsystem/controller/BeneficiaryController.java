package com.crimsonlogic.bankingloanmanagementsystem.controller;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.crimsonlogic.bankingloanmanagementsystem.exceptionhandling.BeneficiaryNotFoundException;
import com.crimsonlogic.bankingloanmanagementsystem.model.Beneficiary;
import com.crimsonlogic.bankingloanmanagementsystem.service.interfaces.IBeneficiaryService;
import com.crimsonlogic.bankingloanmanagementsystem.userimplementation.Customer;

@Controller
@RequestMapping("/beneficiary")
public class BeneficiaryController {

    @Autowired
    private IBeneficiaryService beneficiaryService;

    @GetMapping("/list")
    public String listBeneficiaries(HttpSession session, Model model) {
        Customer customer = (Customer) session.getAttribute("loggedInUser");
        if (customer == null) return "redirect:/login";

        model.addAttribute("beneficiaries", beneficiaryService.getAllBeneficiaries(customer.getCustomerId()));
        return "beneficiary-list";
    }

    @GetMapping("/add")
    public String showAddBeneficiary(HttpSession session) {
        if (session.getAttribute("loggedInUser") == null) return "redirect:/login";
        return "beneficiary-add";
    }

    @PostMapping("/add")
    public String addBeneficiary(
            @RequestParam("name") String name,
            @RequestParam("accountNumber") String accountNumber,
            @RequestParam("bankName") String bankName,
            HttpSession session, Model model) {

        Customer customer = (Customer) session.getAttribute("loggedInUser");
        if (customer == null) return "redirect:/login";

        Beneficiary ben = new Beneficiary(null, name, accountNumber, bankName, customer.getCustomerId());
        beneficiaryService.addBeneficiary(ben);

        model.addAttribute("message", "Beneficiary added successfully.");
        return "redirect:/beneficiary/list";
    }

    @PostMapping("/remove")
    public String removeBeneficiary(@RequestParam("beneficiaryId") String beneficiaryId, HttpSession session, Model model) {
        Customer customer = (Customer) session.getAttribute("loggedInUser");
        if (customer == null) return "redirect:/login";

        try {
            beneficiaryService.removeBeneficiary(beneficiaryId, customer.getCustomerId());
            model.addAttribute("message", "Beneficiary removed.");
        } catch (BeneficiaryNotFoundException e) {
            model.addAttribute("error", e.getMessage());
        }
        return "redirect:/beneficiary/list";
    }
}
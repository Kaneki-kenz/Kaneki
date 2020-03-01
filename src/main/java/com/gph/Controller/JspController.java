package com.gph.Controller;

import com.gph.dao.CountryPortMapper;
import com.gph.entity.CountryPort;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;


import java.util.ArrayList;
import java.util.List;


@Controller
public class JspController {

    @RequestMapping("/AddPort")
    public String index()
    {
        return "index";
    }

    @Resource
    private CountryPortMapper countryPortMapper;

    private List<CountryPort> getData(String countryName,String ip ,Integer skipRows)
    {
        if (skipRows <= 0) skipRows = 0;
        return countryPortMapper.query(countryName,ip,skipRows);
    }

    @ResponseBody
    @RequestMapping("/query")
    public List<CountryPort> query(String countryName, String ip, Integer skipRows)
    {
        if(skipRows == null)
        {
            skipRows = 0;
        }
        System.out.println("Query is run " );
        return  getData(countryName,ip,skipRows);
    }


    @ResponseBody
    @RequestMapping("/queryNot_limit")
    public Integer queryNot_limit(String countryName, String ip)
    {
        return countryPortMapper.queryNot_limit(countryName,ip).size();
    }



    @ResponseBody
    @RequestMapping("/ChangeCountryInfo")
    public Integer ChangeCountryInfo(String countryName,String portString,Integer portId)
    {
        Integer countryId = countryPortMapper.selectCountryIdByName(countryName);
        return  countryPortMapper.ChangeCountryInfo(countryId,portString,portId);
    }





}

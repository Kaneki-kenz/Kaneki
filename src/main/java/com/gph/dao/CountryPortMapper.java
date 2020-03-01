package com.gph.dao;

import com.gph.entity.CountryPort;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface CountryPortMapper {

    // 根据国家名查询可用的端口号
    List<CountryPort> select_port_by_countryName(String countryName);

    // 端口被使用时，设置IP
    Integer SetIP(@Param("ip") String ip,@Param("portId") Integer port_id,@Param("version")Integer version);

    //释放端口号
    Integer ReleasePort(@Param("portString")String portString);


    List<CountryPort> query(@Param("countryName") String countryName,@Param("ip") String ip,@Param("skipRows") Integer skipRows);


    List<CountryPort> queryNot_limit(@Param("countryName") String countryName,@Param("ip") String ip);

    Integer ChangeCountryInfo(@Param("countryId")Integer countryId,@Param("portString")String portString,@Param("portId") Integer portId);

    Integer selectCountryIdByName(@Param("countryName")String countryName);
}

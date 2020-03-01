package com.gph.test;

import com.gph.dao.CountryMapper;
import com.gph.dao.CountryPortMapper;
import com.gph.entity.Country;
import com.gph.entity.CountryPort;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.List;

@RunWith(SpringRunner.class)
@SpringBootTest
@MapperScan("com.gph.dao")
public class RunTest {
    @Autowired
    private CountryMapper countryMapper;
    @Autowired
    private CountryPortMapper countryPortMapper;

    @Test
    public void test()
    {
//        List<Country> list = countryMapper.selectAll();
//        System.out.println(list.toString());
          List<CountryPort> res = countryPortMapper.select_port_by_countryName("秘鲁");
        for (CountryPort c:res) {
            System.out.println(c.toString());
        }
    }
}

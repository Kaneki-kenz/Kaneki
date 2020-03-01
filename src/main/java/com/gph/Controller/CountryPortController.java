package com.gph.Controller;

import com.gph.dao.CountryPortMapper;
import com.gph.entity.CountryPort;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
public class CountryPortController {

    @Resource
    private CountryPortMapper countryPortMapper;

    /**
     * 传入一个国家名称，返回一个该国家可用的代理端口号的 Map
     * @param countryName 国家名称
     * @return
     */
    @RequestMapping("/GetPort")
    public Map<String,String> GetPort(String countryName)
    {
        Map<String,String> map = new HashMap<String, String>();
        if(countryName.trim() != "" && !countryName.isEmpty())
        {
            List<CountryPort> list = countryPortMapper.select_port_by_countryName(countryName);
            CountryPort cp;
            if(!list.isEmpty())
            {
                cp = list.get(0);
                map.put("代理端口号",cp.getPortString());
                map.put("国家",cp.getCountry().getCountryName());
                map.put("PortID",String.valueOf(cp.getPortId()));
                map.put("Version",String.valueOf(cp.getVersion()));
            }
            else
            {
                map.put("Error","不存在可用的代理端口");
            }
        }
        else
        {
            map.put("Error","参数不能为空");
        }
       return map;
    }

    /**
     * @param ip  本机IP
     * @param port_id   端口号id
     * @param version   更新次数
     * @return
     */
    @RequestMapping("/SetIP")
    public Map<String,String> SetIP(String ip,Integer port_id,Integer version)
    {
        Integer update_res = countryPortMapper.SetIP(ip,port_id,version);
        Map<String,String> map = new HashMap<String, String>();
        // update = 0 说明该 IP 已经被设置
        if(update_res == 1)
        {
            map.put("更新ip","true");
        }
        else
        {
            map.put("更新ip","false");
        }
        return map;
    }

    /**
     * 释放该端口号
     * @return
     */
    @RequestMapping("/ReleasePort")
    public Map<String,String> ReleasePort(String portString)
    {
        Map<String,String> map = new HashMap<String, String>();
        Integer ReleaseResult = countryPortMapper.ReleasePort(portString);
        if(ReleaseResult == 1)
        {
            map.put(portString,"释放成功");
        }
        else
        {
            map.put(portString,"端口不存在");
        }
        return map;
    }



}

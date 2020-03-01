package com.gph.entity;

public class CountryPort {
    public Integer portId;
    public String portString;
    public Integer countryId;
    public String ip;
    public Integer version;

    public Country country;

    public Country getCountry() {
        return country;
    }

    public void setCountry(Country country) {
        this.country = country;
    }

    public Integer getVersion() {
        return version;
    }

    public void setVersion(Integer version) {
        this.version = version;
    }

    @Override
    public String toString() {
        return "CountryPort{" +
                "portId=" + portId +
                ", portString='" + portString + '\'' +
                ", countryId=" + countryId +
                ", ip='" + ip + '\'' +
                '}';
    }

    public Integer getPortId() {
        return portId;
    }

    public void setPortId(Integer portId) {
        this.portId = portId;
    }

    public String getPortString() {
        return portString;
    }

    public void setPortString(String portString) {
        this.portString = portString;
    }

    public Integer getCountryId() {
        return countryId;
    }

    public void setCountryId(Integer countryId) {
        this.countryId = countryId;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }
}

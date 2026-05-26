package egovframework.example.sample.service.impl;

import java.util.List;
import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

/**
 * DB 쿼리(XML)를 호출하기 위한 인터페이스입니다.
 */
@Mapper("sampleMapper")
public interface SampleMapper {

    /**
     * sample_mysql.xml의 id="selectTest"인 쿼리를 실행합니다.
     */
    List<?> selectTest() throws Exception;
}
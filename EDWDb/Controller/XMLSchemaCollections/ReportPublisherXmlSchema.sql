CREATE XML SCHEMA COLLECTION [Controller].[ReportPublisherXmlSchema]
    AS N'<xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <xsd:element name="Configuration">
    <xsd:complexType>
      <xsd:complexContent>
        <xsd:restriction base="xsd:anyType">
          <xsd:sequence>
            <xsd:element name="Batch" maxOccurs="unbounded">
              <xsd:complexType>
                <xsd:complexContent>
                  <xsd:restriction base="xsd:anyType">
                    <xsd:sequence>
                      <xsd:element name="Schedule">
                        <xsd:complexType>
                          <xsd:complexContent>
                            <xsd:restriction base="xsd:anyType">
                              <xsd:sequence />
                              <xsd:attribute name="Name" type="xsd:string" use="required" />
                              <xsd:attribute name="Type" type="xsd:string" use="required" />
                              <xsd:attribute name="EventProcedureName" type="xsd:string" use="required" />
                            </xsd:restriction>
                          </xsd:complexContent>
                        </xsd:complexType>
                      </xsd:element>
                      <xsd:element name="Report" maxOccurs="unbounded">
                        <xsd:complexType>
                          <xsd:complexContent>
                            <xsd:restriction base="xsd:anyType">
                              <xsd:sequence minOccurs="0">
                                <xsd:element name="Parameter" minOccurs="0" maxOccurs="unbounded">
                                  <xsd:complexType>
                                    <xsd:complexContent>
                                      <xsd:restriction base="xsd:anyType">
                                        <xsd:sequence />
                                        <xsd:attribute name="Name" type="xsd:string" use="required" />
                                        <xsd:attribute name="Value" type="xsd:string" use="required" />
                                        <xsd:attribute name="Type" type="xsd:string" use="required" />
                                        <xsd:attribute name="ValueFunctionName" type="xsd:string" />
                                      </xsd:restriction>
                                    </xsd:complexContent>
                                  </xsd:complexType>
                                </xsd:element>
                              </xsd:sequence>
                              <xsd:attribute name="Name" type="xsd:string" use="required" />
                              <xsd:attribute name="ID" type="xsd:string" use="required" />
                              <xsd:attribute name="Code" type="xsd:unsignedInt" use="required" />
                              <xsd:attribute name="RelativeOutputLocation" type="xsd:string" use="required" />
                              <xsd:attribute name="ExcelSheetName" type="xsd:string" use="required" />
                              <xsd:attribute name="ExcelSheetPosition" type="xsd:unsignedByte" use="required" />
                              <xsd:attribute name="OutputFileType" type="xsd:string" use="required" />
                              <xsd:attribute name="Encoding" type="xsd:string" use="required" />
                              <xsd:attribute name="Type" type="xsd:string" use="required" />
                              <xsd:attribute name="Path" type="xsd:string" use="required" />
                              <xsd:attribute name="IsFileNameDatePrefixRequired" type="xsd:string" use="required" />
                              <xsd:attribute name="IsFileNameTimePrefixRequired" type="xsd:string" use="required" />
                              <xsd:attribute name="IsHeaderExcluded" type="xsd:string" use="required" />
                            </xsd:restriction>
                          </xsd:complexContent>
                        </xsd:complexType>
                      </xsd:element>
                    </xsd:sequence>
                    <xsd:attribute name="Name" type="xsd:string" use="required" />
                    <xsd:attribute name="ID" type="xsd:string" use="required" />
                    <xsd:attribute name="Code" type="xsd:unsignedInt" use="required" />
                    <xsd:attribute name="OutputLocation" type="xsd:string" use="required" />
                    <xsd:attribute name="Type" type="xsd:string" use="required" />
                  </xsd:restriction>
                </xsd:complexContent>
              </xsd:complexType>
            </xsd:element>
          </xsd:sequence>
        </xsd:restriction>
      </xsd:complexContent>
    </xsd:complexType>
  </xsd:element>
</xsd:schema>';


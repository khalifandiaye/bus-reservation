<?xml version="1.0" encoding="UTF-8"?>
<!-- Licensed to the Apache Software Foundation (ASF) under one or more contributor 
	license agreements. See the NOTICE file distributed with this work for additional 
	information regarding copyright ownership. The ASF licenses this file to 
	You under the Apache License, Version 2.0 (the "License"); you may not use 
	this file except in compliance with the License. You may obtain a copy of 
	the License at http://www.apache.org/licenses/LICENSE-2.0 Unless required 
	by applicable law or agreed to in writing, software distributed under the 
	License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS 
	OF ANY KIND, either express or implied. See the License for the specific 
	language governing permissions and limitations under the License. -->
<!-- $Id$ -->
<xsl:stylesheet version="1.1"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format"
	exclude-result-prefixes="fo">
	<xsl:output method="xml" version="1.0" omit-xml-declaration="no"
		indent="yes" />
	<xsl:param name="versionParam" select="'1.0'" />
	<!-- ========================= -->
	<!-- root element: reservation -->
	<!-- ========================= -->
	<xsl:template match="reservation">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<fo:layout-master-set>
				<fo:simple-page-master master-name="simpleA4"
					page-height="29.7cm" page-width="21cm" margin-top="2cm"
					margin-bottom="2cm" margin-left="2cm" margin-right="2cm">
					<fo:region-body />
				</fo:simple-page-master>
			</fo:layout-master-set>
			<fo:page-sequence master-reference="simpleA4">
				<fo:flow flow-name="xsl-region-body">
					<fo:block font-family="Arial" font-size="12pt" font-weight="bold" space-after="5mm">
						Người đặt:
						<xsl:value-of select="bookerName" />
					</fo:block>
					<fo:block font-family="Arial" font-size="12pt" font-weight="bold" space-after="5mm">
						Mã đặt vé:
						<xsl:value-of select="code" />
					</fo:block>
					<fo:block font-family="Arial" font-size="12pt">
						<fo:table table-layout="auto" width="100%"
							border-collapse="collapse">
							<fo:table-column />
							<fo:table-column />
							<fo:table-column />
							<fo:table-column />
							<fo:table-column />
							<fo:table-column />
							<fo:table-header>
								<fo:table-cell>
									<fo:block font-weight="bold">Trạm</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block font-weight="bold">Ngày đi / Ngày đến</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block font-weight="bold">Ghế</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block font-weight="bold">Loại xe</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block font-weight="bold"></fo:block>
								</fo:table-cell>
							</fo:table-header>
							<fo:table-body>
								<xsl:apply-templates select="ticket" />
							</fo:table-body>
						</fo:table>
					</fo:block>
					<fo:block font-family="Arial" font-size="12pt" font-weight="bold" space-after="5mm">
						Tổng cộng:
						<xsl:value-of select="basePrice" /> đồng
						($ <xsl:value-of select="basePriceInUSD" />)
					</fo:block>
					<fo:block font-family="Arial" font-size="12pt" font-weight="bold" space-after="5mm">
						Phí:
						<xsl:value-of select="transactionFee" /> đồng
						($ <xsl:value-of select="transactionFeeInUSD" />)
					</fo:block>
					<fo:block font-family="Arial" font-size="12pt" font-weight="bold" space-after="5mm">
						Thành tiền:
						<xsl:value-of select="totalAmount" /> đồng
						($ <xsl:value-of select="totalAmountInUSD" />)
					</fo:block>
					<xsl:if test="refundedAmount">
						<fo:block font-family="Arial" font-size="12pt" font-weight="bold"
							space-after="5mm">
							Đã hoàn lại:
							<xsl:value-of select="refundedAmount" /> đồng
							($ <xsl:value-of select="refundedAmountInUSD" />)
						</fo:block>
					</xsl:if>
				</fo:flow>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>
	<!-- ========================= -->
	<!-- child element: ticket     -->
	<!-- ========================= -->
	<xsl:template match="ticket">
		<fo:table-row>
			<xsl:if test="function = 'lead'">
				<xsl:attribute name="font-weight">bold</xsl:attribute>
			</xsl:if>
			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="departureStation" />
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="departureDate" />
				</fo:block>
			</fo:table-cell>
			<fo:table-cell number-rows-spanned="2">
				<fo:block>
					<xsl:value-of select="busType" />
				</fo:block>
			</fo:table-cell>
			<fo:table-cell number-rows-spanned="2">
				<fo:block>
					<xsl:for-each select="seat">
						<xsl:value-of select="." />
					</xsl:for-each>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell number-rows-spanned="2">
				<fo:block>
					<xsl:choose>
						<xsl:when test="status ='active' and ../../status = 'unpaid'">
							Chưa thanh toán
						</xsl:when>
						<xsl:when test="status ='active' and ../../status = 'paid'">
							Đã thanh toán
						</xsl:when>
						<xsl:when test="status ='pending'">
							Chờ khởi hành
						</xsl:when>
						<xsl:when test="status ='cancelled'">
							Đã huỷ
							<fo:block />
							Do <xsl:value-of select="cancelReason" />
						</xsl:when>
						<xsl:when test="status ='refunded'">
							Đã hoàn tiền
							<fo:block />
							Khách hàng huỷ
						</xsl:when>
						<xsl:when test="status ='refunded2'">
							Đã hoàn tiền
							<fo:block />
							Do <xsl:value-of select="cancelReason" />
						</xsl:when>
					</xsl:choose>
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
		<fo:table-row>
			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="arrivalStation" />
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="arrivalDate" />
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>
</xsl:stylesheet>

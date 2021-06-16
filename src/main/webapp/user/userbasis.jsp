<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="/WEB-INF/custom_tag.tld" prefix="custom" %>

<c:set var="language"
       value="${not empty param.language ? param.language : not empty language ? language : pageContext.request.locale}"
       scope="session"/>
<fmt:setLocale value="${language}"/>
<fmt:setBundle basename="locale/resources"/>
<html>
<head>
    <title>MyEvents</title>
</head>
<body style="background-image: url(https://cdn.substack.com/image/fetch/f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fbucketeer-e05bbc84-baa3-437e-9518-adb32be77984.s3.amazonaws.com%2Fpublic%2Fimages%2F97b1c8e4-b31e-42a1-9d93-83fe161f56b2_1920x1075.jpeg)">
<jsp:include page="/common/header2.jsp"/>
<h2><strong>
    <fmt:message key="welcomeText"/>
</strong>
</h2>
<hr/>
<hr>
<div2 class="album py-5 bg-light">
    <div class="container">
        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-4">

            <c:forEach var="item" items="${userExhib.keySet()}">
                <c:set var="tickets" value="${userExhib.get(item)}"/>
                <div class="col">
                    <div class="card shadow-sm">
                        <img class="card-img-top" src=${item.imageUrl} alt="Picture" style="max-height: 240px">
                        <div class="card-body">
                            <c:choose>
                                <c:when test="${language != 'uk'}">
                                    <p class="card-text"><strong>${item.theme}</strong></p>
                                    <p class="card-text">${item.date}</p>
                                </c:when>
                                <c:otherwise>
                                    <p class="card-text"><strong>${item.themeUk}</strong></p>
                                    <p class="card-text"><custom:formatDate value="${item.date}"
                                                                            pattern="dd/MM/yyyy"/></p>
                                </c:otherwise>
                            </c:choose>
                            <div class="d-flex justify-content-between align-items-center">
                                <div class="btn-group">
                                    <button type="button" class="btn btn-sm btn-outline-secondary disabled">Tickets: ${tickets}</button>
                                    <button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
                                </div>
                                <small class="text-muted">${item.max-item.current} <fmt:message
                                        key="ticketsLeft"/></small>
                                <small class="text-muted">${item.price} <fmt:message key="uah"/></small>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div2>
<hr>
</body>
</html>



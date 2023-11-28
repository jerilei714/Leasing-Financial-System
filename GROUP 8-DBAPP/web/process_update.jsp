<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="AssetManagement.Asset" %>

<%
    // Retrieve parameters from the form
    int assetId = Integer.parseInt(request.getParameter("assetId"));
    String assetName = request.getParameter("assetName");
    String description = request.getParameter("description");
    String assetType = request.getParameter("assetType");
    String category = request.getParameter("category");
    String purchaseDate = request.getParameter("purchaseDate");
    float purchaseCost = Float.parseFloat(request.getParameter("purchaseCost"));
    String warrantyInfo = request.getParameter("warrantyInfo");
    String assetCondition = request.getParameter("assetCondition");
    int addressId = Integer.parseInt(request.getParameter("addressId"));

    // Create an instance of Asset and update the information
    Asset asset = new Asset();
    asset.setAssetId(assetId);
    asset.setAssetName(assetName);
    asset.setDescription(description);
    asset.setAssetType(assetType);
    asset.setCategory(category);
    asset.setPurchaseDate(java.sql.Date.valueOf(purchaseDate));
    asset.setPurchaseCost(purchaseCost);
    asset.setWarrantyInfo(warrantyInfo);
    asset.setAssetCondition(assetCondition);
    asset.setAddressId(addressId);

    // Update the asset information in the database
    int result = asset.updateAsset(assetId, assetName, description, assetType, category, 
                                   java.sql.Date.valueOf(purchaseDate), purchaseCost, 
                                   warrantyInfo, assetCondition, addressId);

    // Redirect to a page to display the updated information
    if (result == 1) {
        response.sendRedirect("updated_asset_info.jsp?assetId=" + assetId);
    } else {
        response.sendRedirect("error.jsp"); // Redirect to an error page or handle accordingly
    }
%>

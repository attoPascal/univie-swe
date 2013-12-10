<%@ page language="java" contentType="text/html; charset=US-ASCII" pageEncoding="US-ASCII" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="hm.Hotel" %>
<%@ page import="hm.Zimmer" %>
<%@ page import="hm.Kategorie" %>
<%@ page import="hm.servlets.ZimmerManagement" %>
<%@ page import="hm.dao.DAO" %>

<%
	ZimmerManagement zm = new ZimmerManagement();
	
	ArrayList<Zimmer> zList = hotel.getZimmerList();
	ArrayList<Kategorie> kList = hotel.getKategorien();
	
	Hotel hotel = zm.getDAO().getHotelByName("CrazySharkyFish");
%>

<!DOCTYPE html>

<html>
<head>
	<title>Zimmer verwalten</title>
	<meta charset="US-ASCII">
	<script src="js/jquery.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$("select.set-kategorie").change(function() {
				$.get(
					"ZimmerManagement",
					{
						action: "set",
						zimmer: $(this).attr("data-zimmer"),
						kategorie: $(this).val(),
						hotel: "CrazySharkyFish"
					},
					function(response) {
						$("textarea").text(response);
					}
				);
			});
		});
	</script>
</head>

<body>

	<h1>Zimmer verwalten</h1>

	<textarea rows="1" cols="20" id="response"></textarea>
	
	<table>
		<tr>
			<th>Zimmer</th>
			<th>Kategorie</th>
			<th></th>
		</tr>

		<% for (Zimmer z : zList) { %>
		<tr>
			<td>
				<input type="text" value="<%= z.getNummer() %>" size="4" readonly="readonly">
			</td>
			<td>
				<select size="1" class="set-kategorie" data-zimmer="<%= z.getNummer() %>">
					<% for (Kategorie k : kList) {
						String selected = (k.hasZimmer(z.getNummer())) ? "selected=\"selected\"" : "";
					%>
					<option value="<%= k.getName() %>"<%= selected %>><%= k.getName() %></option>
					<% } %>

				</select>
			</td>
			<td>
				<form action="ZimmerManagement" method="get">
					<input type="hidden" name="action" value="delete">
					<input type="hidden" name="hotel" value="CrazySharkyFish">
					<input type="hidden" name="zimmer" value="<%= z.getNummer() %>">
					<input type="submit" value="-">
				</form>
			</td>
		</tr>
		<% } %>
		</table>
		
		
		<form action="ZimmerManagement" method="get">
			<table>
				<tr>
					<td>
						<input type="hidden" name="action" value="create">
						<input type="hidden" name="hotel" value="CrazySharkyFish">
						<input type="text" name="zimmer" size="4">
					</td>
					<td>
						<select name="kategorie" size="1">
							<option>- Kategorie -</option>
							<% for (Kategorie k : kList) { %>
							<option value="<%= k.getName() %>"><%= k.getName() %></option>
							<% } %>
						</select>
					</td>
					<td>
						<input type="submit" value="+">
					</td>
				</tr>
			</table>
		</form>

	

</body>

</html>
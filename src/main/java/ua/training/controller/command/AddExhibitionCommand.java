package ua.training.controller.command;

import ua.training.model.entity.Exhibition;
import ua.training.model.service.ExhibitionService;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

public class AddExhibitionCommand implements Command {
    private final ExhibitionService exhibitionService = new ExhibitionService();
    private static final String EN_REGEX = "^(?=.*[A-Za-z0-9]$)[A-Za-z][A-Za-z\\d.-]{2,}$";
    private static final String UA_REGEX = "[А-ЩЬЮЯЫҐЄІЇа-щьюяыґєії0-9\\']{2,}";
    private static final String URL_REGEX = "https?:\\/\\/(www\\.)?[-a-zA-Z0-9@:%._\\+~#=]{1,256}\\.[a-zA-Z0-9()]{1,6}\\b([-a-zA-Z0-9()@:%_\\+.~#?&//=]*)";

    @Override
    public String execute(HttpServletRequest request) {
        String result;
        String error = "";
        int price;
        Map<String, String> map = new HashMap<>();
        String theme = request.getParameter("theme");
        String themeUk = request.getParameter("themeUk");
        String description = request.getParameter("description");
        String descriptionUk = request.getParameter("descriptionUk");
        String imageUrl = request.getParameter("imageUrl");
        String date = request.getParameter("date");
        LocalDate ld = LocalDate.parse(date);
        try {
            price = Integer.parseInt(request.getParameter("price"));
        } catch (NumberFormatException e) {
            error = "invalidPrice";
            request.getSession().setAttribute("error", error);
            return "/admin/adminbasis.jsp";
        }
        if (ld.isBefore(LocalDate.now())) {
            error = "invalidDate";
            request.getSession().setAttribute("error", error);
            return "/admin/adminbasis.jsp";
        }
        map.put(theme, EN_REGEX);
        map.put(themeUk, UA_REGEX);
        map.put(description, EN_REGEX);
        map.put(descriptionUk, UA_REGEX);
        map.put(imageUrl, URL_REGEX);
        for (String str : map.keySet()) {
            if (str != null & !str.matches(map.get(str))) {
                request.getSession().setAttribute("error", error);
                return "/admin/adminbasis.jsp";
            }
        }
        Exhibition exhibition = Exhibition.builder()
                .themeUk(themeUk)
                .descriptionUk(descriptionUk)
                .theme(theme)
                .date(ld)
                .price(price)
                .imageUrl(imageUrl)
                .build();
        if (!exhibitionService.create(exhibition)) {
            result = "/admin/adminbasis.jsp";
            error = "invalidDate";
            request.getSession().setAttribute("error", error);
            return result;
        }
        return "redirect:/success.jsp";
    }

}

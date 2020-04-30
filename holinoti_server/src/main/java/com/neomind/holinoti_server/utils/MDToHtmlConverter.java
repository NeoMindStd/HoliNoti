package com.neomind.holinoti_server.utils;

import com.vladsch.flexmark.html.HtmlRenderer;
import com.vladsch.flexmark.parser.Parser;
import com.vladsch.flexmark.util.ast.Node;
import com.vladsch.flexmark.util.data.MutableDataSet;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.core.io.support.ResourcePatternResolver;
import org.springframework.util.FileCopyUtils;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.charset.StandardCharsets;

public class MDToHtmlConverter {
    public static String CLASS_PATH = "classpath:";
    public static String STATIC_PATH = "static/";
    public static String MARKDOWN_PATH = STATIC_PATH + ".markdown/";
    ClassLoader cl;
    ResourcePatternResolver resolver;

    public MDToHtmlConverter() {
        cl = getClass().getClassLoader();
        resolver = new PathMatchingResourcePatternResolver(cl);
    }

    public static String resourceToString(Resource resource) throws IOException {
        byte[] bytes = new byte[0];
        bytes = FileCopyUtils.copyToByteArray(resource.getInputStream());
        String jsonTxt = new String(bytes, StandardCharsets.UTF_8);
        return jsonTxt;
    }

    public static String extensionMDToHtml(String mdFileName) {
        return mdFileName.replaceAll("[.][mM][dD]", ".html");
    }

    public static String insertStringToHtml(String title, String content) {
        return "<!DOCTYPE html>\n" +
                "<html lang=\"en\">\n" +
                "<head>\n" +
                "    <meta charset=\"UTF-8\">\n" +
                "    <title>" + title + "</title>\n" +
                "</head>\n" +
                "<body>\n" +
                content +
                "</body>\n" +
                "</html>";
    }

    public void renderAllMarkdowns() throws IOException {
        Resource[] markdowns = getAllMarkdowns();
        for (Resource markdown : markdowns) {
            render(extensionMDToHtml(markdown.getFilename()), resourceToString(markdown));
        }
    }

    public Resource[] getAllMarkdowns() throws IOException {
        return resolver.getResources(CLASS_PATH + MARKDOWN_PATH + "*");
    }

    public void render(String fileName, String markdownString) throws IOException {
        MutableDataSet options = new MutableDataSet();

        // uncomment to set optional extensions
        //options.set(Parser.EXTENSIONS, Arrays.asList(TablesExtension.create(), StrikethroughExtension.create()));

        // uncomment to convert soft-breaks to hard breaks
        //options.set(HtmlRenderer.SOFT_BREAK, "<br />\n");

        Parser parser = Parser.builder(options).build();
        HtmlRenderer renderer = HtmlRenderer.builder(options).build();

        // You can re-use parser and renderer instances
        Node document = parser.parse(markdownString);
        String html = insertStringToHtml(fileName, renderer.render(document));  // "<p>This is <em>Sparta</em></p>\n"

        BufferedWriter bw = new BufferedWriter(new FileWriter(cl.getResource(STATIC_PATH).getFile() + fileName));
        bw.write(html);
        bw.close();

        System.out.println("MDToHtmlConverter generate a file: " + cl.getResource(STATIC_PATH).getFile() + fileName);
    }
}

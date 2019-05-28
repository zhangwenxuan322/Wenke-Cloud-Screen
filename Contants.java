package com.yzh.itteam.bean;

import static android.R.id.list;

/**
 * Created by yzh on 2016/9/11.
 */

public class Contants {
    /**
     * 域名地址 校方
     */
    public static final String baseUrl = "http://221.226.251.244:5188/wenkor_service/";

    /**
     * 域名地址 校方
     */
    public static final String baseUrl2 = "http://221.226.251.244:5188/";

    /**
     * 域名地址 文客方
     */
    public static final String baseUrl_wenkor2 = "http://218.94.133.45:16635/wenkor/servapi/";
    /**
     * 域名地址 文客方
     */
    public static final String baseUrl_wenkor = "http://yp.wenkor.com:16635/wenkor/servapi/";

    /**
     * 定时间歇时间
     */
    public static final int timeInterval = 1000*30;
    /**
     * 定时Ontich时间 1s
     *
     */
    public static final int timeIntervalOntick =1000;
    /**
     * 学校列表
     */
    public static final String schoolist= baseUrl+"school/news/list";
    /**
     * 学校	分类列表
     */
    public static final String newscatalog= baseUrl+"school/news/catalog";
    http://221.226.251.244:5188/wenkor_service/school/news/catalog
    /**
     * 学校 分类详情
     */
    public static final String newscatalogDetail_1= baseUrl+"school/news/";
    public static final String newscatalogDetail_2= "/detail";
    http://221.226.251.244:5188/wenkor_service/school/news/
    http://221.226.251.244:5188/wenkor_service/school/detail
    /**
     * 首页banner
     */
    public static final String BANNER=baseUrl_wenkor+"yp/getBanner";

    /**
     * 签到 url
     */
    public static final String QIANDAO="http://218.94.133.45:16635/cloudScreen/signIn.html";

    /**
     * 福利 urlwelfare
     */
    public static final String FULI="http://218.94.133.45:6635/cloudScreen/welfare.html";

    /**
     * wenkor首页配置信息
     */
    public static final String getIndexInfo=baseUrl_wenkor+"yp/getIndexInfo";
    http://yp.wenkor.com:16635/wenkor/servapi/yp/getIndexInfo
    /**
     * wenkor 菜单分类
     */
    public static final String content_menu=baseUrl_wenkor+"yp/content_menu";
    /**
     * wenkor 内容详情
     */
    public static final String content =baseUrl_wenkor+"yp/content";
    /**
     * wenkor 红包图片url
     */
    public static final String getBonusUrl =baseUrl_wenkor+"yp/getBonusUrl";
    http://yp.wenkor.com:16635/wenkor/servapi/yp/getBonusUrl
    /**
     * wenkor详情
     */
    public static final String content_info =baseUrl_wenkor+"yp/content_info";
    http://yp.wenkor.com:16635/wenkor/servapi/yp/content_info

    /**
     * 详情页面二维码图标
     */
    public static final String wenkor_logo= "http://api.wenkor.com/wk/product_info.html?id=";

    public static final String wenkor_logo1= "&type=";

}

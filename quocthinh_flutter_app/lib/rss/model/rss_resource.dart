class RssRsources{
  String id, name;
  String startImageRegrex, endImageRegrex;
  String startDescriptionRegrex, endDescriptionRegrex;
  Map<String,String> headers;

  RssRsources({
  required this.id,
  required this.name,
  required this.startImageRegrex,
  required this.endImageRegrex,
  required this.startDescriptionRegrex,
  required this.endDescriptionRegrex,
  required this.headers
});
}
List<RssRsources> rssRsources =[
  RssRsources(
    id:"vnxpress", name:"VN Express ",
    startDescriptionRegrex:"</a></br>",endDescriptionRegrex:"",
    startImageRegrex:'img src="',endImageRegrex:'"',
    headers:{
      "Trang chủ":"https://vnexpress.net/rss/tin-moi-nhat.rss",
      "Tin mới nhất":"https://vnexpress.net/rss/tin-moi-nhat.rss",
      "Thế Giới":"https://vnexpress.net/rss/the-gioi.rss",
      "Công nghệ":"https://vnexpress.net/rss/cong-nghe.rss",
      "Pháp luật":"https://vnexpress.net/rss/phap-luat.rss"
    },

  ),
  RssRsources(
      id:"tuoi_tre", name:"Tuổi trẻ",
      startDescriptionRegrex:"</a>",endDescriptionRegrex:"",
      startImageRegrex:'img src="',endImageRegrex:'"',
      headers:{
        "Trang chủ":"https://tuoitre.vn/rss/tin-moi-nhat.rss",
        "Kinh Doanh":"https://tuoitre.vn/rss/kinh-doanh.rss",
        "Văn Hóa":"https://tuoitre.vn/rss/van-hoa.rss",
        "Công nghệ":"https://tuoitre.vn/rss/nhip-song-so.rss",
        "Pháp luật":"https://tuoitre.vn/rss/phap-luat.rss"
      }
  )
];
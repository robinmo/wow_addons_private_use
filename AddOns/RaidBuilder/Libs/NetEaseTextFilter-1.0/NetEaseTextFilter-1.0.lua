--[[
    by Jai
    814683@qq.com
    2014-3-27 12:47:38
]]--

local MAJOR, MINOR = "NetEaseTextFilter-1.0", 1
local TextFilter, oldminor = LibStub:NewLibrary(MAJOR, MINOR)

if not TextFilter then return end

-- wow apis
local random, match, format, gsub, byte, sub = fastrandom, string.match, string.format, string.gsub, string.byte, string.sub

-- bad words english & chinese total 1565
local blackList = {[101] = ",e夜青,e夜情,", [102] = ",fuk,fucker,fuckin,", [103] = ",gan你,gamemy,", [104] = ",huang段子,huang色,", [106] = ",jian你,jiba,jiaochuang,jiaochun,jb,jr.ztgame,jinku,", [107] = ",kakajb,", [108] = ",loudong,", [109] = ",mg.51hit,", [110] = ",nazi,", [111] = ",olgad,onhave,", [113] = ",qiangjian,qq A.V.A,qeeloo,", [115] = ",sex,saobi,saohuao,sī服,speed.qq,", [116] = ",taobao,tianxungame,", [117] = ",ucdao,", [119] = ",whoyo,wow520,wow711,wowcaifu,wowassist,wowbank,wowjingye,wangyou99,", [121] = ",yz.go2game,yeeplay,yifeng,", [122] = ",zhicheng163,zirui,", [123] = ",{性}交,", [226] = ",“A”片,④ ℉,④ 服,⒋Ｆ,④服,⒋复,", [227] = ",㈣服,", [228] = ",不爽不要钱,习近平,东条,东亚,亀頭,交配,你爸,你妈逼,中功,乳頭,代練,俞正声,三K党,乱伦,乳交,乳房,他妈的,丁关根,东条英机,东突,东亚病夫,乱交,你姥姥,你妈,你妈比,你奶,不发的去死,传奇世界,传奇外传,代连,代涟,代琏,丁磊,丁三石,东亚病夫日本大和,五一七三,仙剑OL,仙剑奇侠传,仙侣奇缘2,丫挺,一液情,三石,三唑仑,丝袜,俬服,伺服,似服,你TM个B,你奶奶,你他妈,亲日,人妻,人妖,三点,三十万同胞,三十万中国人,他爸,他爹,他姥姥,他妈,他奶奶,他娘,他爷,下贱,下体,一党,一黨,一夜情,一中一台,于幼军,俞正聲,中共,中国共产党,中國共產黨,中國狗,中國豬,中华人民共和国,中華人民共和國,专政,作爱,上有网,互友财富,代练,你娘,你爷,侬着冈峦,侬着卵抛,人大,人大常委,人代,人民代表,人民代表大会,人民代表大會,乳头,乳腺,乳晕,乳罩,三个代表,三级片,三去车仑工力,他NND,他吗的,他奶奶的,他娘的,何德普,九一八,久游,举报的狗,乱囵,俞正声 哥哥,俞正声 家族,令JH,令家党,令匪计划,令计划 大内总管,令计划 大秘,仆,低價金幣,中国华日本帝军国主义大,中国人有时候是很贱,中国网络游戏,中华民国,中央,伟人薄,东方闪电,七灵派,二次救主派,令计划 政治秘书,令计划 幕僚长,令计划 团派,令计划 共青团势力,令计划 运城,令狐计划 主任,主任 令狐计划,中南海 大内总管,中南海 幕僚长,九常委,九长老,中共高层权利,中共暴政,一党独裁,一党专政,习 JP,习 太子,习 王储,习 储君,习胖子,习 假博士,九哥,下架 康师傅,人寿 儿子 刘乐飞,人寿 刘乐飞 儿子,上海帮,三呆表,五不搞,", [229] = ",八路,册那娘比,台聯黨,台獨,台灣獨立,呂秀蓮,宋楚瑜,外挂,外•挂,外••挂,外@挂,外@@挂,外~~挂,娼妓,大b,大j8,大东亚共荣,大血比,吊子,发仑,发沦,发论,干bi,干比,干你,干你老母,干一家,刚比样子,国务院,國權,基地組織,劉少奇,六四民运,妈比,吗的,卖比,内衣,奶罩,孙中山,國民黨,幹,幹你,幹妳,姦,媽的,小穴,吃屎,吃大便,婊,哭夭,哭么,做愛,勃起,強姦,強暴,屁眼,奶頭,做爱,傻B,基地组织,外··挂,外·挂,射精,刘少奇,吴邦国,吴官正,周永康,尉健行,大便,军妓,卖淫,强奸,叫床,妓院,奶子,婊子养的,嫖客,干屄,勃不起斯懦夫,勃大精深,卵子,口交,喇嘛,小泉纯一郎,小犬蠢一狼,小鸡鸡,屄,屌,山口组,希特勒,干死,弟大物勃,张宏堡,外~挂,周恩来,列宁,回良玉,刘淇,刘云山,吴仪,张立昌,张德江,台独,台湾独立,屁股,妓女,吹箫,包皮,婊子,傻逼,共产党,共军,国民党,大东亚,共荣圈,共匪,外$挂,啊无卵,包pi,婊zi,册老,册那,册那娘饿比,処女,处女膜,大逼,大比,大法,大鸡巴,发抡,发伦,发纶,发轮,干逼,干的你,干她,干你老比,干你娘,干全家,干他,冈峦,刚比,公告,共產黨,国家领导人,国家主席,国权,國家領導人,國家主席,國務院,含鳥,妓,奸你,奸污,姜春云,叫春,开苞,客服,客户服务,列寧,劉淇,劉雲山,六四,六四民運,六四事件,妈B,妈的,売春婦,卖逼,卖骚,内裤,奶头,妳娘,做鸡,八九风波,八九年天安门事件,包你射,彩虹岛Online,娍人,充值漏洞,处女,催情,催情药,大/法,大FA,大富翁OL,大规模屠杀,带连,带练,待练,党政,党中央,倒扁,地下城勇士,地下城与勇士,叼毛,叼你,屌你,多党,多益网络,反华,反恐行动,反中,分裂主义,封神榜,封神榜2,午夜小电影,勿忘国耻,吸阴,小保姆,小浪妹,寻仙,姚文元,婬獸,婬娃,少妇,刷点卡,刷点卡方法,刷了几千点够玩,双飞,双飛,四服,命令与征服,内射,南京大屠杀,女优,女優,呛马围陈,強奷,强 奸,强姦,强女干,去你妈,全裸视频,台湾,天皇,天龙八部,天晴数码,偷怕,偷拍,偷情,完美国际,完美时空,完美世界,吳邦國,吳官正,吳儀,吾尔开希,吾爾開希,小B样,小比样,小便,张万年,張德江,張宏堡,張立昌,張萬年,周恩來,專政,子宫,奇乐网,卡卡金币,娘比,娘饿比,尿,女干,屁精,嫖娼,强暴,傻比,傻吊,傻鸟,山本,山本五十六,射了,射了还说要,十八摸,十六大,屎,台湾獨立,台湾国,台灣狗,台灣国,台灣國,台灣豬,太监,天阉,同房,台湾岛国万岁,反党,吸毒,大麻,刘晓波,大秘 令计划,土肥原贤二,广田弘毅,冈村宁次,勇者传说,员0,员０,员1,员１,员2,员２,员3,员３,员4,员４,员5,员５,员6,员６,员7,员７,员8,员８,员9,员９,员八,员二,员九,员零,员六,员七,干你妈,弓虽女干,公安,共产,共党,光 屁股,光*屁股,国民党当,嘿咻,华国锋,华中方面军,加速器,假的封包,奸,奸夫,奸淫,姦你,姦淫,剑网,剑侠情缘,剑侠世界,叫鸡,叫雞,劲舞团,巨人online,巨人网络,姖乳,军国主义,开赌,开房,开房间,康生,尻,口袋西游,垃圾GM,垃圾网易,六合彩,倮聊,媽B,卖批,卖霪,免费版,免费刷网易点卡,张德江 动车,动车 张德江,哥哥 俞正声,家族 俞正声,娃娃脸随员,大内总管 令计划,官方,匯款,台幣,员三,员十,员四,员五,员一,张春桥,征途,志治致旨智,做AI,彭丽媛,全能神,全能神教会,全能神教,实际神,天安门事件,张高丽,幕僚长 令计划,团派 令计划,共青团势力 令计划,大内总管 中南海,幕僚长 中南海,共惨党,共残党,军头异动,太子党,十八 江 胡,十八 内斗,内斗 十八,十八.*权斗,十九.权斗 十八,十八.*恶斗,十九.恶斗 十八,平西王 薄,太子 习,储君 习,半羽,假博士 习,吴龙 新邮通,广隶,十大黑领,周永康家族,康师傅 下架,儿子 刘乐飞 人寿,儿子 人寿 刘乐飞,刘乐飞 儿子 人寿,刘乐飞 人寿 儿子,刘延东 女婿,女婿 刘延东,团派 李源潮,团派 汪洋,刘永清,古月金帛三寿,古月总,党魁,当今圣上,当今皇上,团派,天线宝宝 锦湖轮胎,儿子 涛哥,前核心,太上皇 江,天线宝宝 康师傅,康师傅 天线宝宝,假庆淋,广大木木,", [230] = ",比水,操b,操蛋,操她,操那吗逼,操你娘,操你祖宗,操王,插B,插比,插那吗逼,插你爸,民進黨,李登輝,林榮一,李克强,插你奶奶,插你祖宗,戳B,戳比,戳那吗比,東突,法抡,法沦,法论,房事,搞死,滚那吗B,滚那吗瘟比,江澤民,拉皮条,滥B,滥比,李大師,李瑞環,林彪,毛澤東,民運,摸你鸡巴,李大师,李登辉,智冠,操妳,欠幹,打砲,懶叫,淫,淫蕩,淫賤,打手槍,早洩,情兽,江泽民,曾庆红,李长春,朱镕基,李瑞环,李岚清,李洪志,法轮,撒尿,性无能,操你奶奶,日本帝国,法$$轮,法^轮,游戏道,我有网,法$轮,法^^轮,法@轮,法@@轮,法~~轮,性交,我操,我日,操你,支那,日你,日你妈,本拉登,梅毒,次郎,淫荡,淫魔,游戏管理员,毛泽东,恩格斯,温家宝,曹刚川,曾培炎,李鹏,拉登,法轮功,法轮大法,恐怖主义,淫秽,操逼,淫水,打炮,月经,放荡,招妓,日他娘,操你妈,法~轮,比卵,比样,操比,操狗,操鸡,操那吗B,操那吗比,操你爸,操你老母,操你全家,操你爷爷,操死,操他,插逼,插她,插那吗B,插那吗比,插你,插你老母,插你妈,插你娘,插你全家,插你爷爷,插他,插我,戳逼,戳那吗B,戳那吗逼,打飞机,東亞病夫,法仑,法伦,法纶,法倫,法論,搞你,滚那吗,滚那吗错比,滚那吗老比,懶趴,滥逼,滥货,滥交,李長春,李嵐清,李鵬,李铁映,民运,明慧,摸你,摸你全身,按键精灵,暴漏图片,暴露图片,波 霸,惨绝人寰,操,操死垃圾,成人电影,成人片,成人网站,春宫图,春秋Q传,春药,春葯,春藥,打倒政府,法lun,法X功,法发珐,法西斯,放屁,我草,我靠你吗,武林外传,性感妹妹,性奴,性慾,摇头丸,涩晴网,文化部,水浒Q传,死b,死难同胞,松井石根,民族,民族天皇皇军万岁爱,泡泡岛,泡泡堂,朋友妻,抢姧,撽情,清純MM,情色中心,日本大和,日的WY,日批,桃色交易,淘宝,新闻出版总署,温比,文胸,新疆獨立,新疆独立,性爱,性病,性高潮,性虐待,性器,性生活,性息,性欲,淫货,淫贱,淫乱,於幼軍,欲女,援交,杂种,早泄,曾慶紅,招鸡,政府,政协,政協,政治局,政治局常委,政治协商会议,政治協商會議,朱德,朱狨基,朱容基,易玩网,新视野工作室,捏你鸡巴,捏你奶子,日本,日本人,日逼,日穿,日蛋,日军,日你爸,日你老母,日你奶奶,日你娘,日你全家,日你爷爷,日你祖宗,日死,日王,杀你全家,杀你一家,湿了还说不要,湿了还说要,手淫,捅B,捅逼,捅比,捅她,捅你,捅我,慰安妇,慰安婦,温B,温逼,新疆分裂,新疆国,暴动,抽头,木村兵太郎,武藤章,拉斯维加斯,淫妇,淫靡,淫你,淫片,淫妻,淫娃,永恒之塔,悠游,浩方对战平台,洪红宏鸿弘,换偶,换妻,潢铯,混蛋,憿情片,激情,激情片,激情视频,激情視ullet 頻,激情網站,激情小电影,极品爽片,江独裁,江狗,江青,接练级,晋江原创网,抗议,李宏旨,林立果,流血冲突,毛片,毛片 色书,毛润之,梅花网乳房,梦幻要倒闭,民主党,智凡迪,新幹線,新斷線,智障,操你媽的,支持台独,最新刷点方法,最新刷卡,新能力主教会,海洛因,汪洋,李源潮,政治秘书 令计划,总竖鸡,政治派系,护士长 王丽娟,李吉林省会,新邮通 吴龙,李K强,李克弓虽,李源潮 团派,汪洋 团派,汪洋 蛋糕论,涛哥的鄙视,江 胡 斗,江 斗 胡,斗 胡 江,斗 江 胡,涛哥 儿子,江 ZM,江核心,江Core,江贼民,水工泽民,江戏子,江 太上皇,江派,江系人马,江家帮,江锦恒,温 JB,温影帝,温秀秀,温+饱,情妇 贾庆林,", [231] = ",王俊博,狗比,狗幹,狗剩,管理员,砍翻一条街,烂逼,精童欲女,睪丸,精水,精蟲,私服,罗干,王乐泉,王兆国,狗屁,爱滋,王八蛋,狗狼养的,皇军,煞笔,疆独,精子,精液,狗日的,纳粹,白痴,班禅,發倫,粪便,糞,睾丸,狗操,狗卵,狗娘,狗杂种,疆獨,经血,精童,砍死你,烂B,烂比,烂货,爱爱,穿越火线,玳理,玳练,玳链,玳練,独立革命,犯贱,疯狂飚车,网易的狗,网易养的狗,网易赚黑钱,网之易,系统数据号,炫舞QQ,煞B,神鬼传奇,神经病,盛大易聊,盛大在线,石器时代,私 Ｆ,私F,私℉,私副,男妓,热舞派对,热血传奇,突厥,网 淫 ★ 荡,网E,网龙,网易,网易倒闭,版署,热比,热逼,瘟B,瘟比,猶太豬,真善忍,知的障害,知障,玖玖金币,网游久久金币,紫瑞专业,皮条客,禽兽,私处,私—服,田纪云,王八,猥亵,热比娅,稀特勒,癮水,玉娇饼,玉蒲团,狗B,狗叼,狗贱,狗娘养的,狗日,狗样,红袖添香网,皇军万岁,簧网,火石软件,继女,禁片,禁网,烈火工作室,绿营,牦片,美乳,缅怀30万,現貨,猪日的,维园,真光派,真道派,王立军,王岐山,红色权贵,王丽娟 护士长,王总兵,王储 习,祸国强,王山支山,纳米比亚 胡,病危 蛤蟆,私生子 西贝,", [232] = ",膀胱,謝長廷,肛門,賈慶林,贱B,贱逼,贱人,老B,老比,轮公,輪公,西藏,親民黨,肏,賤,草枝麻,草芝麻,賣幣,胡锦涛,贺国强,轮奸,该漏洞至今用,肛交,茎候佳阴,蒋介石,达赖,赵紫阳,胡耀邦,贾庆林,萨达姆,花柳,荡妇,赤匪,藏獨,藏独,车仑,车仑女干,迟浩田,达賴,达癞,腚眼,肛jiao,肛门,胡錦濤,贱bi,贱比,贱货,贱种,老逼,老卵,轮攻,輪攻,蜜穴,藏青会,草你,肏穴,超爽电影,舂药,舂葯,舂藥,處囡,處女,蠢b,蚮连,蚮炼,蚮練,荡娃,胴体,赌博,西.游.Q.记 iyoyo,西藏局势,西游Q记,艳 照,艳女,艳照,色 情,色·情·,色qing网,色戒,色魔,色情,色情服务,色情小电影,色图 色片,色网,身份证生成器,起点小说网,肉体,肉慾,肉柱,腾讯,腾迅,舔阴,脫光光,脱衣,西藏獨立,西藏独立,行房,胸部,胸罩,贞操,自焚,自慰,让你操,肉棒,肉洞,肉棍,身寸米青,身体障害者,身障,臺湾國,臺灣國,西藏分裂,西藏国,藏妇会,走私,茉莉花,赌场,赌坊,胡景涛,西特勒,诱惑,誘惑,谷寿夫,蒋经国,蒋中正,解放军,解密的原码,警察,蓝营,老毛,联众世界,轮功,轮奸虐杀,轮姦,輪姧,裸,裸聊,裸照,迷奸,迷奸药,迷药,迷晕,臺幣,購金,賣月卡,買月卡,買幣,运维,诛仙,赚黑钱,装B,装处女,资料处理中心,自动报警,自动打怪,自动交票,自动识别价格,自动识别奖励框,自动智能跑,自拍,自尉,自由党,薄来哥,薄亲王,赵维山,薄熙来,运城 令计划,裆中央,薄督,薄 平西王,胡 JT,胡核心,胡 Core,胡和谐,胡河蟹,胡一刀,胡 纳米比亚,胡 江 斗,胡 斗 江,胡瘟,蛤蟆 病危,误邦国,贾庆林 情妇,西贝 私生子,", [233] = ",逼孕,避孕,陳水扁,連戰,馬英九,陈毅,陳毅,遲浩田,错比,错那吗比,達赖,黑鬼,黄片,鸡奸,靖国神社,那吗错比,那娘错比,韩正,骚逼,鸡巴,黑手党,雞八,雞巴,雞雞,靠夭,靠么,陰蒂,陰道,陽萎,陰莖,陽具,魔獸幣,雞掰,邓小平,黄菊,郭伯雄,骚货,阴毛,鸡鸡,阴茎,阿扁,陈水扁,马克思,陈良宇,阴部,阴道,阴唇,鸡八,龟头,鬼公,野鸡,逼孕套,避孕套,陈云,陳雲,错B,错逼,错那吗B,错那吗逼,達賴,鄧小平,龟公,龟投,龜頭,鸡8,鸡吧,鸡女,鸡院,金枪不倒,那吗B,那吗逼,那吗老比,那吗瘟比,那娘老比,那娘瘟比,逼毛,逼玩意,鄙视WY,鄙视网易,陈马会,陈玉娇,黄色电影,香艳,阳器,阴阜,魔兽管理员,铁血三国志,透你妈,魔兽金币,金币网,魔兽金库,顏射,阳具,阳痿,阳物,野合,阴蒂,阴户,阴精,阴门,阴囊,陰戶,造爱,雨星网,龙腾工作室,钱其琛,骚B,骚棒,骚包,骚棍,骚鸡,骚卵,魏京生,鸦片,錦濤,高 潮,龟孙子,闺房,鬼子帝国天皇,黑帮,黑社会,黃網,黄she,黄wang,黄色网,黄色网站,黄色小电影,黄色小说,黄网 小电影,黄网,黄网导航,鸡奸你,金瓶梅,金山多益,金山软件,開 苞,马克思主义,马英九,骂驴,遊戲新幹線,遊戲新斷線,遊戲幣,魔幣,黄华华,陆肆,锦涛,面瘫帝,黄海刺胡,锦湖轮胎 天线宝宝,", [239] = ",４Ｆ,４℉,４扶,Ａ片,ｑ号,Ｓ 服,Ｓ服,", [40] = ",(四)服,(五)Ｓ  Ｆ,", [49] = ",18摸,1937年,18大,", [51] = ",30万同胞,30万中国人,39CK,39仓Ku,", [53] = ",5173,50zhou,58jb,", [54] = ",6.4事件,64事件,68wow,64yl,", [55] = ",71周年,", [57] = ",9c,9city,9城,988wow,9JBW,", [65] = ",A片,AV,A网,", [66] = ",Baichi,Baopi,Bao皮,BC,Biao子,Bi样,", [67] = ",Core 江,", [68] = ",DAI 练,Dai连,Dai练,", [70] = ",Fuck,", [71] = ",Gamemanger,Gm,", [72] = ",H 片,", [74] = ",J8,Ji女,Jasmine,JP 习,JT 胡,JB 温,", [75] = ",KAO,", [77] = ",Mai骚,MBD,Molihua,", [81] = ",QING色电影,QQ飞车,QQ华夏,QQ三国,QQ堂,QQ仙境,", [83] = ",Sb,SHIT,SE情电影,SF,SF 私ｆ,", [84] = ",The9,TNND,TheNine,TMD,Tuo衣视频,", [87] = ",Waigua,", [90] = ",ZM 江,", [97] = ",anus,ai滋,asshole,", [98] = ",bastard,bitch,biaozi,", [99] = ",caobi,caoB,cao你,cha你,cf.qq ava.,",}

-- placeholder
local randomword = {'!', '@', '#', '$', '&', '^', '*'}
local count = #randomword

-- placeholder text cache
local PlaceholderText = setmetatable({}, {
    __mode = 'k',
    __index = function(t, k)
        local result = ''
        for i=1, k do
            result = result .. randomword[random(1, count)]
        end
        t[k] = result
        return t[k]
    end,
    })

-- key algorithm
local function FilterEngine(text)
    local index, badword
    local len = #text
    for i=1, len do
        local list = blackList[byte(text, i, i)]
        if list then
            for j = i, len do
                badword = match(list, format(',(%s[^,]+),', sub(text, i, j)))
                if not badword then
                    break
                end
                text, index = gsub(text, badword, PlaceholderText[#badword])
                if index > 0 then
                    break
                end
            end
        end
    end
    return text
end

-- filtered text cache
local SafeWords = setmetatable({}, {
    __mode = 'k',
    __index = function(t, k)
        local result, text = pcall(FilterEngine, k)
        t[k] = result and text or k
        return t[k]
    end,
    })

function TextFilter:TextFilter(text)
    return text and SafeWords[text] or nil
end

TextFilter.embeds = TextFilter.embeds or {}

local mixins = {
    'TextFilter',
}

function TextFilter:Embed(target)
    TextFilter.embeds[target] = true

    for i, v in ipairs(mixins) do
        target[v] = TextFilter[v]
    end

    return target
end

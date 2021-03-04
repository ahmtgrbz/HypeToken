# HypeToken
**Erc-20 token Creating Çalışması**


<table> <tr> <td align="center"><a href="https://github.com/ahmtgrbz"><img src="https://avatars0.githubusercontent.com/u/44843548?s=460&v=4" width="100px;" alt=""/><br /><sub><b>Ahmet GÜRBÜZ</b>
</tr>
</table>

## **Çalışma Neden Ve Nasıl Yapıldı ?**

Bu çalışmayı solidty diline biraz daha fazla hakim olmak. Farklı github kütüphanelerin remix üzerinde nasıl kullanıldığını anlamak ve Akıllı kontratların nasıl oluşturulduğunu anlamak ve bu alanda genel bilgimi ve tecrübemi arttırarak gelecekte bu alanda çalışma ihtimalimi arttırmak istediğim için bu çalışmayı yaptım.
Bu çalışma genel olarak uygulama kısmından çok araştırma kısmının daha yoğun olduğu bir çalışma olarak gerçekleşti. Öncelikle kaynaklardan akıllı sözleşmenin ne olduğu ve nasıl çalıştıklarını araştırmam gerekti. Ardından akıllı sözleşmek için gerekli olan solidity dilindeki keywordleri ve syntax yapısını öğrendim. Sonrasında erc20 standartlarının ve etherium ağının genel olarak neler olduğunu öğrendim. 


İlk araştırmalarım sonucu bulduğum tutorial videolar veya kaynaklar genelde solidity'nin eski versiyonlarında yazılmış ve biraz eskimiş içerikler oldu. Tabi bunu fark etmem biraz zaman aldı. Örneklerdek gibi kodlama yaptığımda bir çok error ile karşılaştım daha sonra bu hataların versiyon farkından kaynaklandığını anladım. Kod yazmayı bırakıp güncel içerikleri araştırmaya devam ettim bu araştırma sırasında bir token oluşturmak için birkaç kütüphane ve yardımcı araç olduğunu keşfettim.Bu araçlar bir sözleşmeyi erc20 standartlarını(interfaceni) kullanıp gerekli fonksiyonları override etmişlerdi. Kullanmak istediğimiz fonksiyonları kendi parametrelerimiz ile çağırmanız ve bunları kullanarak tokenimizi oluşturmamız gerekiyordu. Bunlardan birincisi openzeppelin ve diğeri truffle kütüphansesiydi. Openzeppelin ile çalışmaya karar verdim ve hem yapısını anlamak hemde nasıl uygulandığının örneklerini görmek için openzeppelin forumunda dolaşmaya başladım. Basitçe bir token nasıl oluşturulur göstermişlerdi. Aynı şekilde uyguladım. Adını,sayısını,kısa adını belirledim. Local olarak kontratı oluşturdum ve çalıştığını gördüm. Ardından metamask kullanarak bunu bir test ağı üzerinde denemek için bir hesap oluşturdum. Ropsten test ağı için hesabıma eth yükledim. Ve remix de yazmış olduğum kodla kontrat oluşturup bunu ağa gönderdim. Bu şekilde token oluşmuş ve test ağına girmiş oldu. Sonrası için ise test ağında ilk arkadaşlarıma token transferi yaptım ve sistemin çalıştığını gördüm sonrasında ise size bir transfer gönderdim.


Genel olarak baktığımda bir çok sorun ve hala eksiklik hissediyorum. Şöyleki tokeni oluşturdum fakat tokeni etherscan üzerinde doğrulayamadım. Bunun nedeni kontratı remix üzerinden test ağına eklemiş olmak. Oppenzeppelin kullandığım için tokeni onaylamak istediğimde onaylama için 3 seçenek sunuyor bunlardan biri tek bir solidity file ile diğeri ise çoklu bir sol. dosyaları ile. Burada oppenzeppelin forumunun üzerinde araştırma yaptığımda (https://forum.openzeppelin.com/t/how-to-verify-a-contract-deployed-using-remix-importing-openzeppelin-via-github/2413) doğrudan bir doğrulama yapılamadığını truffle-flattener kullanılarak tek bir döküman haline getirmek üzere projeyi doğruladıklarını anladım. Fakat windows ortamında bunu nasıl yapılacağını ve truffle'ın nasıl kullanıldığını kavrayamadığım için bu işlemi gerçekleştiremedim. 


## **ERC20 Standartları**
**Genel Anlamda erc20 standartlarını bir kontrat uyması gerekirse altı zorunlu fonksiyonu içermesi gerekir. Bunlar;**

*1-* totalSupply,

*2-* balanceOf,

*3-* transfer,

*4-* transferFrom,

*5-* approve,

*6-* allowance

fonksiyonlarıdır.

bu fonksiyonlar openzeppelin kütüphansesinde contracts\token\ERC20.sol içinde bulunmaktadır. Bu dosyayı ve fonksiyonları inceleyecek olursak;


* "function totalSupply() public view virtual override returns (uint256)"* fonksiyonu doğrudan toplam arzı sorgulamak için oluşturulmuştur. Burada view olarak yazılmasının sebebi yanlızca değer döndürmek istemesi. Herhangi bir değişiklik yapmayacağı için ağ üzerindeki tüm kontratlardan bunu alması veya sorgulaması gerekmediği için yazılmış durumda. 

 
* "function balanceOf(address account) public view virtual override returns (uint256)"* fonksiyonu ise adresteki ona verilen adresteki toplam balace dönecektir. Aynı şekilde buradada değer üzerinde bir değişiklik yapmayacağımız için view olarak fonksiyon yazılmış. Adresini bildiğimiz sürece tüm hesapların balance miktarını bu fonksiyon yardımı ile sorgulayabiliriz.

* "function transfer(address recipient, uint256 amount) public virtual override returns (bool)"* fonksiyonu 2 parametre alır. Bunlardan birincisi alıcının adresi diğeri ise gönderilecek miktardır. bu fonksiyon çalıştırıldığında bir kaç kontrol yapılıyor. Bunlar alıcının adresi 0 olamaz, göndericinin adresi 0 olamaz, gönderici göndereceği miktardan az bir bakiyeye sahip olamaz, ve gönderici aynı anda 2 gönderim yapamaz. Bu kontroller geçildiğinde emit fonksiyonu ile transfer başlatılıyor. Ayrıca burada transfer sonucunun başarılımı yoksa başarısız mı olduğunu dönmek için boolean bir değer döndürmüşüz.

* "function transferFrom(address sender, address recipient, uint256 amount) public virtual override returns (bool)"*  bu fonksiyon sayesinde tokenları yine transfer edebiliriz ancak tokenların kontatı çağıran kişiye ait olması gerekmiyor.Daha açıkça bir sistemi yada kişiyi, yetkilendirerek tokenlarınızı hareket ettirebilirsiniz. Buradaki temel hedef aylık yada haftalık gibi yapılan düzenli ödemelerin otomatik hale getirilebilmesidir. Transfer ile aynı şekilde fonksiyon içinde bazı kontroller yapılır. Bunlar gönderen ve alıcı adresileri sıfır  olamaz,gönderenin göndereceği tutardan fazla bakiyesi olmalıdır,bu işlemde yetkili kişinin allowance dediğimiz izin verilen transfer edilebilecek coin miktarından kalan miktarın aşılmamış olması gerekir. Bu kontrollerden geçilmesi durumunda emit keywordü ile transfer başlatılır.Sonucu yine boolen bir değer olarak döndürürüz.

* "function _approve(address owner, address spender, uint256 amount) internal virtual"* fonksiyonu bir akıllı kontratın hesabınızda hareket ettirebileceği coin miktarını sınırlamanıza yarayan fonksiyondur. Bu fonksiyon olmaması durumunda kendi kontratımızın her hangi bir hack ile karşılaşması durumunda hesabımız boşaltılabilir. approve fonksiyonu yine 2 kontrolden geçer bunlar alıcı ve göndericinin adreslerinin 0 olmaması kontrolüdür. Bu durumlar gerçekleşmediği taktirde onaylama fonksiyonu emit keyword'ü yardımı ile tetiklenir. Burada eklemek gerekir. Böyle bir limit varsa limiti sonradan arttırıp azaltmamız gerekebileceği için openzeppelin kütüphanesi Bu değeri arttırma ve azaltma fonksiyonuda barındırmaktadır.

* "function allowance(address owner, address spender) public view virtual override returns (uint256)"* bu fonksiyon ise approve fonksiyonu ile birlikte kullanılıyor denilebilir. Bu fonksiyon approve fonksiyonu ile daha önce belirlenen miktardan geriye ne kadar kaldığını sorgulamak için vardır. burada yine alıcı gönderici adresi 0 olmamalıdır. Ayrıca yine değerler üzerinde bir değişiklik yapmayacağımız için view keywordü kullanılmıştır.



Bu fonksiyonlara ek olarak name, symbol, decimal fonksiyonlarıda openzeppelin kütüphanesinde bulunmaktadır. Name tokenımızın adını,symbol sembolünü ve decimal noktadan sonra kaç basamaklı bir bölümün desteklendiğini bize geri döndürür.
Ayrıca bu kütüphanede standart olarak Safemath.sol dosyası bulunmaktadır. Bu dosyada matematiksel kontroller yapılır çünkü solidity dilinde transfer işlemlerinde overflow olabilir. Bu dosyada bu taşma durumu olduğunda tespit edilmesi ve yapılan transaction'ın geriye döndürülmesi için kullanılır. Yani aslında aritmatik hatalar gerçekleşmeden önlem almakl için kullanılan dosylardır. 



## **Bu token Neden Oluşturuldu ?** 

Bu tokenın amacı genel olarak benim solidity dilini kavramam fonksiyonların yazıldığında nasıl bir mantıkla hangi kontrollerden sırasıyle geçtiğini öğrenmem için yazıldı. Ayrıca kütüphanlerin içeriğini incelememde ciddi anlamda fonksiyon yazmada bana fikir verdi(openzepplin).  Ancak daha spesifik bir amaca hizmet etmesi gerekiyorsa otomatik ödemeler ve aboneliklerde kullanılabilecek bir ödeme aracı olarak yaratılmış olabilir.


Dip Not: Openzeppelin kütüphanesi ile oluşturlan bir token nasıl etherscan üzerinde onaylanır hala çözemedim.

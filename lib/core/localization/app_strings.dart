class AppStrings {
  AppStrings._();

  // ═══════════════════════════════════════════
  //  App
  // ═══════════════════════════════════════════
  static const String appName = 'Busino';
  static const String appTagline = 'سفر شهری هوشمند';

  // ═══════════════════════════════════════════
  //  Splash
  // ═══════════════════════════════════════════
  static const String loading = 'در حال بارگذاری...';

  // ═══════════════════════════════════════════
  //  Auth
  // ═══════════════════════════════════════════
  static const String login = 'ورود';
  static const String register = 'ثبت‌نام';
  static const String logout = 'خروج';
  static const String mobile = 'شماره موبایل';
  static const String password = 'رمز عبور';
  static const String confirmPassword = 'تکرار رمز عبور';
  static const String firstName = 'نام';
  static const String lastName = 'نام خانوادگی';
  static const String loginWelcome = 'خوش آمدی! 👋';
  static const String loginSubtitle = 'وارد حسابت شو و سفرت رو شروع کن.';
  static const String registerWelcome = 'حساب جدید بساز';
  static const String registerSubtitle = 'چند ثانیه‌ای طول می‌کشه.';
  static const String noAccount = 'حساب نداری؟';
  static const String haveAccount = 'قبلاً ثبت‌نام کردی؟';
  static const String forgotPassword = 'رمزت رو فراموش کردی؟';

  // Validation
  static const String fieldRequired = 'این فیلد الزامی است';
  static const String mobileInvalid = 'شماره موبایل نامعتبر است';
  static const String passwordShort = 'رمز باید حداقل ۶ کاراکتر باشد';
  static const String passwordMismatch = 'رمزها یکسان نیستند';
  static const String mobileExists = 'این شماره قبلاً ثبت شده';
  static const String wrongCredentials = 'شماره یا رمز اشتباه است';

  // ═══════════════════════════════════════════
  //  Home
  // ═══════════════════════════════════════════
  static const String goodMorning = 'صبح بخیر';
  static const String goodAfternoon = 'ظهر بخیر';
  static const String goodEvening = 'عصر بخیر';
  static const String goodNight = 'شب بخیر';
  static const String homeSubtitle = 'مبدأ و مقصدت رو بگو تا بهترین خط رو پیدا کنیم.';
  static const String searchRoute = 'جست‌وجوی مسیر';
  static const String originHint = 'مبدأ — مثلاً میدان ولیعصر';
  static const String destHint = 'مقصد — مثلاً دانشگاه';
  static const String findBestRoute = 'پیدا کردن بهترین خط';
  static const String specialSuggestion = 'پیشنهاد ویژه‌ی تو';
  static const String allRoutes = 'همه‌ی خط‌های موجود';
  static const String seeAll = 'مشاهده همه';
  static const String bestOption = 'بهترین گزینه';
  static const String nearbyStations = 'ایستگاه‌های نزدیک';
  static const String useMyLocation = 'استفاده از موقعیت من';
  static const String selectManually = 'انتخاب دستی';

  // ═══════════════════════════════════════════
  //  Routes / Trips
  // ═══════════════════════════════════════════
  static const String allLines = 'همه‌ی خط‌ها';
  static const String routesSubtitle = 'هر خط رو با هر تایمی که راحتته انتخاب کن.';
  static const String routeDetails = 'جزئیات خط';
  static const String stops = 'توقف‌گاه‌های مسیر';
  static const String ticketPrice = 'قیمت بلیط';
  static const String minutes = 'دقیقه';
  static const String minuteAway = 'دقیقه دیگر';
  static const String minutesTrip = 'دقیقه سفر';
  static const String metersWalk = 'متر پیاده‌روی';
  static const String seats = 'صندلی';
  static const String capacityFull = 'ظرفیت تکمیل';
  static const String origin = 'مبدأ';
  static const String destination = 'مقصد';
  static const String station = 'ایستگاه';
  static const String available = 'موجود';
  static const String almostFull = 'نزدیک پر';
  static const String full = 'پر';
  static const String departed = 'حرکت کرده';
  static const String cancelled = 'کنسل';

  // ═══════════════════════════════════════════
  //  Reservation / Payment
  // ═══════════════════════════════════════════
  static const String reserve = 'رزرو';
  static const String continueToPayment = 'ادامه به پرداخت';
  static const String payment = 'پرداخت';
  static const String paymentMethods = 'روش پرداخت';
  static const String wallet = 'کیف پول Busino';
  static const String bankCard = 'کارت بانکی';
  static const String balance = 'موجودی';
  static const String toman = 'تومان';
  static const String payAndGetTicket = 'پرداخت و دریافت بلیط';
  static const String termsAgree = 'با زدن این دکمه قوانین و شرایط را می‌پذیرید.';
  static const String insufficientBalance = 'موجودی ناکافی';
  static const String topUpWallet = 'شارژ کیف پول';

  // ═══════════════════════════════════════════
  //  Ticket / Tracking
  // ═══════════════════════════════════════════
  static const String myTicket = 'بلیط من';
  static const String oneTimeTicket = 'بلیط یک‌بار مصرف';
  static const String showQrHint = 'این کد رو موقع سوار شدن به دستگاه کیوآرخوان راننده نشون بده';
  static const String ticketCode = 'کد بلیط';
  static const String seatsAvailable = 'صندلی/ظرفیت';
  static const String amount = 'مبلغ';
  static const String liveTracking = 'مشاهده‌ی موقعیت زنده اتوبوس';
  static const String tripFinished = 'سفر تمام شد — رفتم به مقصد';
  static const String livePosition = 'موقعیت زنده اتوبوس';
  static const String eta = 'زمان تقریبی رسیدن';
  static const String status = 'وضعیت';
  static const String onTheWay = 'در مسیر';
  static const String driverInfo = 'راننده';
  static const String updateEvery3s = 'موقعیت هر ۳ ثانیه به‌روزرسانی می‌شود';
  static const String yourStation = 'ایستگاه تو';

  // ═══════════════════════════════════════════
  //  Waitlist
  // ═══════════════════════════════════════════
  static const String waitlist = 'لیست انتظار';
  static const String yourPosition = 'جایگاه تو در لیست انتظار';
  static const String waitlistFull = 'ظرفیت این اتوبوس تکمیل شده. به محض آزاد شدن جا یا اعزام اتوبوس کمکی، بلیطت رزرو و بهت اطلاع داده می‌شه.';
  static const String peopleInWaitlist = 'نفرات در لیست انتظار';
  static const String threshold = 'آستانه‌ی اعزام اتوبوس کمکی';

  // ═══════════════════════════════════════════
  //  Rating
  // ═══════════════════════════════════════════
  static const String howWasTrip = 'سفر چطور بود؟';
  static const String rateDriver = 'به راننده‌ی این سفر امتیاز بده.';
  static const String yourOpinion = 'نظرت درباره‌ی رانندگی، وقت‌شناسی یا نظافت اتوبوس (اختیاری)';
  static const String submitRating = 'ثبت امتیاز';
  static const String skip = 'رد کردن';
  static const String thanksForRating = 'ممنون از نظرت! امتیاز ثبت شد ✓';

  // ═══════════════════════════════════════════
  //  Profile / History
  // ═══════════════════════════════════════════
  static const String profile = 'پروفایل';
  static const String history = 'تاریخچه‌ی سفرها';
  static const String walletTitle = 'کیف پول';
  static const String help = 'راهنما';
  static const String settings = 'تنظیمات';
  static const String about = 'درباره‌ی ما';
  static const String topUp = 'شارژ کیف پول';
  static const String currentBalance = 'موجودی فعلی';
  static const String selectAmount = 'مبلغ شارژ را انتخاب کنید';
  static const String topUpSuccess = 'کیف پول با موفقیت شارژ شد ✓';
  static const String transactions = 'تراکنش‌ها';
  static const String noTransactions = 'هنوز تراکنشی نداری';

  // ═══════════════════════════════════════════
  //  Bottom Navigation
  // ═══════════════════════════════════════════
  static const String navHome = 'خانه';
  static const String navRoutes = 'خطوط';
  static const String navTicket = 'بلیط من';
  static const String navProfile = 'پروفایل';

  // ═══════════════════════════════════════════
  //  Generic
  // ═══════════════════════════════════════════
  static const String ok = 'باشه';
  static const String cancel = 'انصراف';
  static const String confirm = 'تایید';
  static const String retry = 'تلاش مجدد';
  static const String noResult = 'نتیجه‌ای یافت نشد';
  static const String errorGeneric = 'خطایی رخ داد. لطفاً دوباره تلاش کن.';
  static const String loadingData = 'در حال بارگذاری...';
  static const String comingSoon = 'به زودی...';
}
import 'package:sneako/src/models/brand.dart';

class Defaults {
  static final defaultbrand = Brand(id: 0, name: "All", logo: '');

  static final morebrand = Brand(id: 0, name: 'More', logo: moreLogo);

  static const moreLogo =
      'https://xdvflujqgzxlfcrhujca.supabase.co/storage/v1/object/public/Brands/more.png';
}

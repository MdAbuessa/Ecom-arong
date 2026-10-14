import 'package:aarongonzales01/provider/address.dart';
import 'package:aarongonzales01/provider/auth_provider.dart';
import 'package:aarongonzales01/provider/email.dart';
import 'package:aarongonzales01/provider/get_all_farmers_provider.dart';
import 'package:aarongonzales01/provider/pond_provider.dart';
import 'package:aarongonzales01/provider/provides.dart';
import 'package:provider/provider.dart';

var providers = [
  //New
  ChangeNotifierProvider<AuthProvider>(create: ((context) => AuthProvider())),
  // Old
  ChangeNotifierProvider<EmailProvider>(create: ((context) => EmailProvider())),
  ChangeNotifierProvider<AddressProvider>(
    create: ((context) => AddressProvider()),
  ),
  ChangeNotifierProvider<ItemOptionIndex>(
    create: ((context) => ItemOptionIndex()),
  ),
  // ChangeNotifierProvider<DateTimeProvider>(
  //   create: ((context) => DateTimeProvider()),
  // ),
  ChangeNotifierProvider<VoucherProvider>(
    create: ((context) => VoucherProvider()),
  ),
  ChangeNotifierProvider<PlcaeMarkAddress>(
    create: ((context) => PlcaeMarkAddress()),
  ),
  ChangeNotifierProvider<GenericBool>(create: ((context) => GenericBool())),
  ChangeNotifierProvider<SelectedSubCat>(
    create: ((context) => SelectedSubCat()),
  ),
  ChangeNotifierProvider<GenericProvider>(
    create: ((context) => GenericProvider()),
  ),
  ChangeNotifierProvider<CartCounter>(create: ((context) => CartCounter())),
  ChangeNotifierProvider<PondProvider>(create: ((context) => PondProvider())),

  ChangeNotifierProvider<GetAllFarmersProvider>(
    create: ((context) => GetAllFarmersProvider()),
  ),
  ChangeNotifierProvider<PondObservationProvider>(
    create: ((context) => PondObservationProvider()),
  ),
 
  
];

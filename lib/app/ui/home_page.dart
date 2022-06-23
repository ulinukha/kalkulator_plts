import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kalkulator_plts/app/ui/ProductList.dart';
import 'package:kalkulator_plts/app/widget/recource.dart';
import 'package:kalkulator_plts/app/widget/text_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController electricalPower = TextEditingController();
  TextEditingController spendTime = TextEditingController();
  TextEditingController psh = TextEditingController();
  TextEditingController pshIrradiation = TextEditingController();
  double totalMonthlyEnergy = 0;
  double dailyLoadPlan = 0;
  double dec = 0;
  double inverterCapacity = 0;
  double pvNonInverterCapacity = 0;
  double pvInverterCapacity = 0;
  double batteryCapacity = 0;
  int batteryTotal = 0;
  String currentType = 'DC';

  // rumus 1
  onCountTotalMonthlyEnergy() {
    if (electricalPower.text.isNotEmpty && spendTime.text.isNotEmpty
      && psh.text.isNotEmpty && pshIrradiation.text.isNotEmpty
    ) {
      totalMonthlyEnergy =
          double.parse(electricalPower.text) * double.parse(spendTime.text);
      totalMonthlyEnergy = totalMonthlyEnergy / 1000;
      onCountDailyLoadPlan();
      setState(() {});
    }
  }

  // rumus 2
  onCountDailyLoadPlan() {
    String count = (totalMonthlyEnergy / 30).toStringAsFixed(3);
    dailyLoadPlan = double.parse(count);
    onCountDEC();
    setState(() {});
  }

  // rumus 3
  onCountDEC() {
    String count = (dailyLoadPlan / (95 / 100)).toStringAsFixed(3);
    dec = double.parse(count);
    if (currentType == 'DC') {
      onCountPvNonInverterCapacity();
    } else {
      onCountInverterCapacity();
    }
    onCountBatteryCapacity();
    setState(() {});
  }

  // rumus 4
  onCountInverterCapacity() {
    String count = ((dec/0.75)/(double.parse(psh.text)*double.parse(pshIrradiation.text))).toStringAsFixed(3);
    inverterCapacity = double.parse(count);
    onCountPvInverterCapacity();
    setState(() {});
  }

  // rumus 5
  onCountPvNonInverterCapacity() {
    String count = ((dec/0.75)/(double.parse(psh.text)*double.parse(pshIrradiation.text))).toStringAsFixed(3);
    pvNonInverterCapacity = double.parse(count);
    setState(() {});
  }

  // rumus 6
  onCountPvInverterCapacity() {
    String count = (inverterCapacity * (120/100)).toStringAsFixed(3);
    pvInverterCapacity = double.parse(count);
    setState(() {});
  }

  // rumus 7
  onCountBatteryCapacity() {
    String count = ((dec-dailyLoadPlan)/((0.95*0.2)*1)).toStringAsFixed(3);
    batteryCapacity = double.parse(count);
    onCountBatteryTotal();
    setState(() {

    });
  }

  // rumus 8
  onCountBatteryTotal() {
    double battery = (batteryCapacity/24)/100;
    batteryTotal = battery.ceil();
    setState(() {

    });
  }

  goToProductList() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProductList(
        args: ProductListArgument(
          dailyLoadPlan: dailyLoadPlan,
          currentType: currentType
        ),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Text(
                "Isi data rencanamu",
                style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColor.defaultBlue),
              ),
              const SizedBox(
                height: 20,
              ),
              _buildInputForm(),
              const SizedBox(height: 60,),
              Visibility(
                visible: dailyLoadPlan != 0 && dec != 0,
                  child: _buildResult())
            ],
          ),
        ),
        floatingActionButton: InkWell(
          onTap: () {
            onCountTotalMonthlyEnergy();
          },
          child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 15),
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              decoration: BoxDecoration(
                color: electricalPower.text.isNotEmpty && spendTime.text.isNotEmpty 
                    && psh.text.isNotEmpty && pshIrradiation.text.isNotEmpty ?
                AppColor.defaultBlue : AppColor.defaultBlue.withOpacity(0.4),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "Hitung",
                style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: electricalPower.text.isNotEmpty && spendTime.text.isNotEmpty 
                    && psh.text.isNotEmpty && pshIrradiation.text.isNotEmpty ?
                    Colors.white : Colors.black.withOpacity(0.3)),
                textAlign: TextAlign.center,
              )),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked);
  }

  Widget _buildInputForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: DefaultTextField(
                hindText: 'Energi Listrik(P)', textController: electricalPower),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 1,
              child: DefaultTextField(
                hindText: 'Waktu Pemakaian(hr)', textController: spendTime),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: DefaultTextField(
                hindText: 'PSH', textController: psh),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 1,
              child: DefaultTextField(
                hindText: 'PSH Irradiation', textController: pshIrradiation),
            ),
          ],
        ),
        const SizedBox(height: 15,),
        Row(
          children: [
            _buildCurrentType('DC'),
            const SizedBox(
              width: 10,
            ),
            _buildCurrentType('AC')
          ],
        )
      ],
    );
  }

  _buildCurrentType(String value){
    return InkWell(
      onTap: () {
        setState(() {
          currentType = value;
          dailyLoadPlan = 0;
          dec = 0;
          batteryCapacity = 0;
          batteryTotal = 0;
        });
      },
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: value == currentType ? AppColor.defaultBlue : AppColor.defaultBlue.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          value,
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            color: value == currentType ? AppColor.whiteFefefe : Colors.black.withOpacity(0.4),
            fontWeight: FontWeight.w700
          ),
        ),
      ),
    );
  }

  _buildResult() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColor.defaultBlue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Hasil",
            style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black.withOpacity(0.7)),
          ),
          const SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildResultItem(
                title: 'Rencana Beban Harian',
                value: '$dailyLoadPlan',
                type: 'Watthour'
              ),
              _buildResultItem(
                title: 'DEC',
                value: '$dec',
                type: 'Watthour'
              ),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildResultItem(
                title: 'Kapasitas Baterai',
                value: '$batteryCapacity',
                type: 'Watthour'
              ),
              _buildResultItem(
                title: 'Jumlah Baterai',
                value: '$batteryTotal',
                type: 'Unit'
              ),
            ],
          ),
          const SizedBox(height: 10,),
          currentType == 'DC' ?
          Center(
            child : _buildResultItem(
                title: 'Kapasitas PV Non Inverter',
                value: '$pvNonInverterCapacity',
                type: 'Wattpeak'
              ),
          )
          : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildResultItem(
                title: 'Kapasitas Inverter',
                value: '$inverterCapacity',
                type: 'Watt'
              ),
              _buildResultItem(
                title: 'PV Inverter',
                value: '$pvInverterCapacity',
                type: 'Wattpeak'
              ),
            ],
          ),
          const SizedBox(height: 40,),
          Center(
            child: InkWell(
              onTap: () {
                goToProductList();
              },
              child : Text(
                "Lihat Rekomendasi Produk",
                style: GoogleFonts.montserrat(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColor.defaultBlue),
              ),
            ),
          ),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }

  _buildResultItem({
    required String title,
    required String value,
    required String type
  }) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          height: 45,
          child: Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black.withOpacity(0.7)),
            ),
        ),
        const SizedBox(height: 7,),
        Text(
            '$value $type',
            style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Colors.black.withOpacity(0.7)),
          ),
      ],
    );
  }
}

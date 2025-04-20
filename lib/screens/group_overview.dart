import 'package:flutter/material.dart';
import 'package:frontend/widgets/plant_list_widget.dart';

class GroupOverview extends StatefulWidget {
  const GroupOverview({super.key});

  @override
  State<GroupOverview> createState() => _GroupOverviewState();
}

class _GroupOverviewState extends State<GroupOverview> {
  final plants = [
    (
      title: 'Monstera',
      image:
          'https://florastore.com/cdn/shop/files/3512102_Atmosphere_04_SQ_MJ.jpg?v=1734605722&width=1080',
    ),
    (
      title: 'Yucca',
      image:
          'https://www.houseplant.co.uk/cdn/shop/files/Indoor_Tropical_Yucca_Elephantipes_Elephant_Exotic_Air_Purifying_Easy_Care_Succulent_Houseplant_Range.jpg?v=1738072733&width=1946',
    ),
    (
      title: 'Philodendron',
      image:
          'https://asset.bloomnation.com/c_pad,d_vendor:global:catalog:product:image.png,f_auto,fl_preserve_transparency,q_auto/v1630542296/vendor/4191/catalog/product/2/0/20210824101449_file_61256f59ca3db_61256fa6016cd._612fb763c8680._612fb7661f8de..jpg',
    ),
    (
      title: 'Ivy',
      image: 'https://growhub.ae/cdn/shop/files/Indoor-345.jpg?v=1688218239',
    ),
    (
      title: 'Money Tree',
      image:
          'https://webshop.plnts.com/media/catalog/product/cache/aa5d334f459227518b6c3cf7ea9d29ed/p/l/pl.xxl.012-1-0106.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 64, left: 24, right: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                width: 375,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xFFFCFCFC),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Color(0xFF1B2727),
                    ),
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Color(0xFF92A56E),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Icon(
                        Icons.person_outline_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => {
                        setState(() {
                          plants.add(
                            (
                              title: 'New Plant',
                              image:
                                  'https://media.istockphoto.com/id/1147544807/de/vektor/miniaturbild-vektorgrafik.jpg?s=612x612&w=0&k=20&c=IIK_u_RTeRFyL6kB1EMzBufT4H7MYT3g04sz903fXAk='
                            ),
                          );
                        }),
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Color(0xFFFCFCFC),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Icon(
                          Icons.add_rounded,
                          color: Color(0xFF1B2727),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        for (final plant in plants)
                          PlantListWidget(
                            title: plant.title,
                            image: plant.image,
                            onDelete: () => {
                              print('delete'),
                              setState(() {
                                plants.remove(plant);
                              }),
                            },
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget insertPlantWidget() {
    double offsetX = 0;

    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onPanUpdate: (details) {
          if (details.delta.dx < -10) {
            setState(() {
              offsetX = -100;
            });
            print('Swipe left');
          }
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          transform: Matrix4.translationValues(offsetX, 0, 0),
          width: 375,
          height: 150,
          decoration: BoxDecoration(
            color: Color(0xFFFCFCFC),
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    );
  }
}

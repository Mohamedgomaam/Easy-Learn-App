import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instant1/e_learning/stripe_payment/payment_manager.dart';
import 'package:instant1/e_learning/ui/home/courses/Courses.dart';
import 'package:instant1/e_learning/ui/home/home.dart';
import 'package:instant1/e_learning/ui/home/lesson/page/lessons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../manager/courses_cubit.dart';
import '../manager/courses_state.dart';

class Courses extends StatefulWidget {
  const Courses( {super.key, this.category="",this.called=true,this.fromHome=false,this.fromSearch=false,this.getMyCourses=false});
  final String category;
  final bool called;
  final bool fromHome;
  final bool fromSearch;
  final bool getMyCourses;


  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  final cubit = CoursesCubit();
  bool x=true;
  bool y=true;


  @override
  void initState() {
    super.initState();
    print("==========");
    print(widget.fromHome);
    print(widget.category);
    cubit.getNotesFromFireStore(widget.category,widget.getMyCourses);

  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocBuilder<CoursesCubit, CoursesState>(
        builder: (context, state) {
          return Scaffold(
            appBar: widget.fromSearch ==x ?null:AppBar(
              automaticallyImplyLeading: false,
              leading: widget.fromHome==x? IconButton(
                icon:  const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: ()  {
                  // setState(() {
                  // });
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context)=>const EHome()
                      )
                  );
                 // widget.clicked=false;
                  //widget.fromHome=false;
                },
              ):null,
              title:widget.getMyCourses?Text(
                "My Courses",
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 19.sp,
                    fontWeight: FontWeight.bold
                ),
              ):Text(
                "Our Courses",
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 19.sp,
                    fontWeight: FontWeight.bold
                ),
              ),
              backgroundColor: Colors.grey[200],
              elevation: 0,
            ),
            body: Container(
              color: Colors.grey[200],
              child: ListView.builder(
                  itemCount: cubit.CourseDetails.length,
                  itemBuilder: (context, index) {
                   return buildCourses(index);
                  }
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildCourses(int index) {
    String url = cubit.CourseDetails[index].url;
    return InkWell(
      onTap: (){
        Navigator.push(
            context,MaterialPageRoute(builder: (context)=>CourseDetail(courseDetails: cubit.CourseDetails[index],getMyCourses: widget.getMyCourses,))
        );
        },
      child: Container(
        width: double.infinity,
        padding:  EdgeInsets.all(13.sp),
        margin:  EdgeInsets.all(13.sp),
        decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(23.sp),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding:  EdgeInsets.only(
                  left: 13.sp,
                  right: 13.sp,
                  bottom: 9.sp,
                  top: 9.sp
              ),
              child:Image.network(
                url,
                width: 56.sp,
                height: 56.sp,
              ),
            ),
            Padding(
              padding:EdgeInsets.only(
                  left: 13.sp,
                  right: 13.sp,
                  bottom: 9.sp,
                  top: 9.sp
              ),
              child: Text(
                cubit.CourseDetails[index].title,
                style:  TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 19.sp,
                ),
              ),
            ),
            Padding(
              padding:EdgeInsets.only(
                  left: 13.sp,
                  right: 13.sp,
                  bottom: 9.sp,

              ),
              child: Text(
                "${cubit.CourseDetails[index].lessons} Lessons",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 17.sp,
                ),
              ),
            ),

            Row(
              children: [
                SizedBox(width: 13.sp,),
                Text("Category : ",style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold),),
                Text(cubit.CourseDetails[index].category),
              ],
            ),
            Padding(
              padding:  EdgeInsets.all(12.sp),
              child: Row(
                children: [
                  const Icon(Icons.star,color: Colors.yellow,),
                  Text(cubit.CourseDetails[index].rating),
                  const Spacer(),

                  Text(
                      cubit.CourseDetails[index].price,
                    style:  TextStyle(
                      fontSize: 19.sp,
                      color: Colors.blue
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}






class CourseDetail extends StatefulWidget {
  const CourseDetail({super.key,required this.courseDetails, this.getMyCourses=false });
  final CoursesClass courseDetails;
  final bool getMyCourses;

  @override
  State<CourseDetail> createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {
  final cubit=CoursesCubit();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        leading: IconButton(
          icon:  const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
            widget.courseDetails.title,
          style:  TextStyle(
              color: Colors.blueAccent,
              fontSize: 19.sp,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: Colors.grey[200],
            padding:EdgeInsets.only(
                left: 13.sp,
                right: 13.sp,
                bottom: 9.sp,
                top: 9.sp
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(19.sp), // Image border
              child: SizedBox.fromSize(
                child: Stack(
                  alignment: Alignment.topRight,
                  children:[
                    Image.network(
                      widget.courseDetails.url,
                      fit: BoxFit.cover,
                      width: 100.sp,
                      height: 56.sp,
                    ),
                    Padding(
                      padding:  EdgeInsets.all(13.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                          Container(
                            padding:  EdgeInsets.all(6.sp),
                            decoration:  BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius:  BorderRadius.all(Radius.circular(15.sp),
                                )
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.star,color: Colors.yellow,),
                                Text(widget.courseDetails.rating),
                                const Text(" "),
                              ],
                            ),
                          ),


                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.all(12.sp),
            child: Text(
              widget.courseDetails.title,
              style:  TextStyle(
                  fontSize: 19.sp,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.all(12.sp),
            child: Text(
              widget.courseDetails.description,
              style: TextStyle(
                  fontSize: 16.sp,
                  color:Colors.grey[500],
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.all(12.sp),
            child: Row(
              children: [
                Text(
                  "Professor : ",
                  style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                    widget.courseDetails.prof,
                  style:  TextStyle(
                      fontSize: 16.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 19.sp,),
          Padding(
            padding:  EdgeInsets.all(12.sp),
            child: Row(
              children: [
                Text(
                    "${widget.courseDetails.lessons} Lessons",
                  style:  TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 19.sp
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=>Lessons(courseDetails: widget.courseDetails,)
                        ),
                    );
                  },

                  child:  Text(
                      "See All",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 19.sp
                    )
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 13.sp,),
          Padding(
            padding:  EdgeInsets.all(9.sp),
            child: Row(
              children: [
                widget.getMyCourses? const Text(""):Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      int price=0;
                     if(widget.courseDetails.price=="Free"){

                       await cubit.enrollCourse(widget.courseDetails.id).then((value) => Navigator.pop(context));
                     }
                     else{
                       String x=widget.courseDetails.price.substring(1);
                       print(x);
                       price=int.parse(x);
                       PaymentManager.makePayment(price, "USD").then((value) async {
                         await cubit.enrollCourse(widget.courseDetails.id).then((value) => Navigator.pop(context));

                       }).catchError((error){
                         print("invalid payment ====>>${error.toString()}");
                       });

                     }
                    },
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        backgroundColor: Colors.blue
                    ),
                    child:  Text(
                      'Enroll For ${widget.courseDetails.price} ',
                      style:const TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ) ,
    );
  }
}


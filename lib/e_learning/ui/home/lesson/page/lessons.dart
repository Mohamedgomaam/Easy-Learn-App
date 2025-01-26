import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instant1/e_learning/ui/home/lesson/manager/lessons_cubit.dart';
import 'package:instant1/e_learning/ui/home/lesson/manager/lessons_state.dart';
import 'package:instant1/e_learning/ui/lessons.dart';
import 'package:pod_player/pod_player.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
//import 'package:pod_player/pod_player.dart';
import '../../courses/Courses.dart';

class Lessons extends StatefulWidget {
  const Lessons({super.key, required this.courseDetails});

  final CoursesClass courseDetails;

  @override
  State<Lessons> createState() => _LessonsState();
}

class _LessonsState extends State<Lessons> {
  final cubit = LessonsCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit.getLessonsFromFireStore(courseId: widget.courseDetails.id);
    print("=============== SIZE=======${cubit.lessons.length}");
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocBuilder<LessonsCubit, LessonsState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading:IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back_ios,color: Colors.black,)),
              elevation: 0,
              title: Text(widget.courseDetails.title,style: const TextStyle(color: Colors.blue),),
              backgroundColor:Colors.grey[200] ,
            ),
            backgroundColor: Colors.grey[200],
            body: Container(
              color: Colors.grey[200],
              child: ListView.builder(
                  itemCount: cubit.lessons.length,
                  itemBuilder: (context, index) {
                    return buildLesson(index);
                  }
              ),
            ),

          );
        },
      ),
    );
  }
  Widget buildLesson(int index) {
    String url = widget.courseDetails.url;
    return  Container(
      width: double.infinity,
      padding:  EdgeInsets.all(13.sp),
      margin:  EdgeInsets.all(13.sp),
      decoration: BoxDecoration(
        color: Colors.blue[200], borderRadius: BorderRadius.circular(23.sp),
      ),
      child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.sp), // Image border
              child: SizedBox.fromSize(
                size:  Size.fromRadius(35.sp), // Image radius
                child: Image.network(url, fit: BoxFit.cover),
              ),
            ),
            cubit.enrolled==true?const Text(""):const Spacer(),
            SizedBox(width: 13.sp,),
            cubit.enrolled==true?Text("Watch ${cubit.lessons[index].name}"):Text(cubit.lessons[index].name),
            cubit.enrolled==true?const Spacer():const Text(""),
            SizedBox(width: 13.sp,),
            cubit.enrolled==true? ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,MaterialPageRoute(builder: (context)=>GetLessonVideo(lesson: cubit.lessons[index],))
                );
                //late String link=cubit.lessons[index].videoLink.toString().substring(18,25);
               // print(link);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.sp), // <-- Radius
                ),
              ),
              child: Row(
                children: [
                  const Text('Go ',style: TextStyle(color: Colors.blue),),
                  Icon(Icons.arrow_forward_ios_rounded,size: 17.sp,color: Colors.blue,)
                ],
              ),
            ):const Text("")

          ],

      ),
    );
  }
}




class GetLessonVideo extends StatefulWidget {
  const GetLessonVideo({super.key,required this.lesson});
  final Lesson lesson;

  @override
  State<GetLessonVideo> createState() => _GetLessonVideoState();
}

class _GetLessonVideoState extends State<GetLessonVideo> {

  // late YoutubePlayerController _controller;

  late String link=widget.lesson.videoLink;

  late String uri;
  late final PodPlayerController controller;

  @override
  void initState() {
    // TODO: implement initState
    controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.youtube(widget.lesson.videoLink),
    )..initialise();
    super.initState();
    // uri=YoutubePlayer.convertUrlToId(link)!;
    // _controller = YoutubePlayerController(
    //   initialVideoId: uri,
    //   flags:  const YoutubePlayerFlags(
    //       autoPlay: true,
    //       mute: false
    //   ),
    // );
    // print("================================????${uri}");

  }

  @override
  void dispose() {
    // TODO: implement dispose
    // _controller.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading:IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back_ios,color: Colors.black,)),
        title: Text(widget.lesson.name,style: const TextStyle(color: Colors.blue),),
        centerTitle: true,
        backgroundColor: Colors.grey[200],
        elevation: 0,
      ),
      body: PodVideoPlayer(controller: controller),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:SoCUniteTwo/screens/forum_screens/details/comments.dart';
import 'package:SoCUniteTwo/widgets/provider_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:SoCUniteTwo/screens/forum_screens/post_notes.dart';

class Upvotenotes extends StatefulWidget { //managed for comments
final Comments comment; //takes in a comment 
final PostNotes post;
 Upvotenotes({Key key, @required this.comment, @required this.post}) : super(key: key);
  @override
  _UpvotenotesState createState() => _UpvotenotesState();
}

class _UpvotenotesState extends State<Upvotenotes> {
  bool _isUpvoted = false;
  //int upvoteCount = 0;
  //String _upvote = 'Upvote';

  @override
  void initState() {
    super.initState();
    Firestore.instance.collection('public').document('CS2030').collection('Notes')
    .document(widget.post.documentid).collection('comments').document(widget.comment.documentid).get().then((value) async {
      final uid = await Provider.of(context).auth.getCurrentUID();
      if(value.data['upvotes'] == null ||value.data['upvotes'][uid] == null) {
        widget.comment.upvotes.putIfAbsent(uid, () => false);
        Firestore.instance.collection('public').document('CS2030').collection('Notes')
        .document(widget.post.documentid).collection('comments').document(widget.comment.documentid).setData({
          'upvotes': widget.comment.upvotes,
         }, merge: true).then((_){
        print("success at null for comments saved!");
        });
      }
        else {
          setState(() {
           _isUpvoted = value.data['upvotes'][uid]; 
        });
       print('set state upon opening page');
      }   
    });
  }

  _toggleUpvote() {
  setState(() {
    _isUpvoted = !_isUpvoted;
  });
}

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
            onPressed: () async {
              await _toggleUpvote();
              final uid = await Provider.of(context).auth.getCurrentUID();
              widget.comment.upvotes.update(uid, (value) => _isUpvoted, ifAbsent: () => _isUpvoted);
              await Firestore.instance.collection('public').document('CS2030')
                 .collection('Notes').document(widget.post.documentid).collection('comments')
                 .document(widget.comment.documentid).setData({
                   'upvotes': widget.comment.upvotes, //new field is a map
                 }, merge: true).then((_){
                  print("upvote comment successfully saved to firebase!");
                });     
            },
           icon: Icon(_isUpvoted ? Icons.favorite : Icons.favorite_border,
             size: 25,
             color: _isUpvoted ?  Colors.pink : Colors.pink,),),
        Text(widget.comment.upvotes.values.where((e)=> e as bool).length.toString(), style: TextStyle(color: Colors.grey[100]),),
      ],
    );
  }
}
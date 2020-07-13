import 'package:SoCUniteTwo/widgets/provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:SoCUniteTwo/screens/forum_screens/internship_offers/offer.dart';


//can add validation
//new post for collaborations

class NewOffer extends StatefulWidget {
  final Offer post;
  
  NewOffer({Key key, @required this.post}) : super(key: key);

  @override
  _NewOfferState createState() => _NewOfferState();
}

class _NewOfferState extends State<NewOffer> {
  final db = Firestore.instance;

  String profilePicture;
  String username;


  @override
  Widget build(BuildContext context) {
    TextEditingController _contentController = new TextEditingController();
    TextEditingController _titleController = new TextEditingController();
    TextEditingController _companyController = new TextEditingController();
    TextEditingController _linkController = new TextEditingController();
    TextEditingController _contactController = new TextEditingController();
    
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("Create a post"),
        backgroundColor: Colors.grey[850],
      ),
      body: 
      SingleChildScrollView(
        child:
        Center(child: 
      Column(
        children: <Widget>[
          SizedBox(height: 30),
          Row(children: <Widget>[
            SizedBox(width: 20,),
       Text("Guidelines when making a post", style: TextStyle(fontSize: 16, 
            fontWeight: FontWeight.bold, decoration: TextDecoration.underline, color: Colors.tealAccent), ),
          ],),
           SizedBox(height: 10),
           Row(children: <Widget>[
            SizedBox(width: 20,),
            Text("1)",style: TextStyle(color: Colors.grey[100])),
            SizedBox(width: 10,),
            Expanded(
            child: Text("Title should be kept concised and specific",style: TextStyle(color: Colors.grey[100]),)
          ,),
          SizedBox(height: 30),
          ],),
          Row(children: <Widget>[
            SizedBox(width: 20,),
            Text("2)",style: TextStyle(color: Colors.grey[100])),
            SizedBox(width: 10,),
            Expanded(
            child: Text("Details can mention about internship requirements and what can one expect from the role.  ",style: TextStyle(color: Colors.grey[100]),)
          ,),
          SizedBox(height: 30),
          ],),SizedBox(height: 10),
          Row(children: <Widget>[
            SizedBox(width: 20,),
            Text("3)",style: TextStyle(color: Colors.grey[100])),
            SizedBox(width: 10,),
            Expanded(
            child: Text("Please refrain from using foul or uncivilised words",style: TextStyle(color: Colors.grey[100]),)
          ,),
          SizedBox(height: 30),
          ],),
          Row(children: <Widget>[
            SizedBox(width: 20,),
            Text("4)",style: TextStyle(color: Colors.grey[100])),
            SizedBox(width: 10,),
            Expanded(
            child: Text("If you are providing more than one contact detail, the formatting of your information should be as such:",style: TextStyle(color: Colors.grey[100]),)
          ,),
          ],),
          SizedBox(height: 10),
          Row(children: <Widget>[
            SizedBox(width: 20,),
            Text("Email: 1234@gmail.com",style: TextStyle(color: Colors.grey[100]),)
          ],),
          Row(children: <Widget>[
            SizedBox(width: 20,),
            Text("Mobile: 12345678",style: TextStyle(color: Colors.grey[100]),)
          ],),
          Row(children: <Widget>[
            SizedBox(width: 20,),
            Text("Person to contact: Jonathan ",style: TextStyle(color: Colors.grey[100]),)
          ],),
          SizedBox(height: 10),
          Row(children: <Widget>[
            SizedBox(width: 20,),
            Expanded(
            child: Text("Violation of these guidelines may lead to your post being deleted and you may be temporarily banned from making posts after a repeated number of violations."
            ,style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[100]),)
          ,),
          ],),
          SizedBox(height: 10),
          Divider(thickness: 1, color: Colors.tealAccent),
          SizedBox(height: 20),
          //select type of post
          Row(children: <Widget>[
            SizedBox(width: 20,),
            Text("Title", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,  color: Colors.grey[100])),
          ],),
          
          Padding(
            padding: EdgeInsets.all(15),
            child: TextFormField(
              validator: (value) {
                if(value.isEmpty) {
                  return "Title cannot be empty";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                filled: true,
        fillColor: Colors.grey[100],
        hintText: 'Title',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey),
        ),
            ),
              autofocus: true,
              controller: _titleController,),
          ),
          Row(children: <Widget>[
            SizedBox(width: 20,),
            Text("Company", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[100])),
          ],),
          Padding(
            padding: EdgeInsets.all(15),
            child: TextFormField(
              validator: (value) {
                if(value.isEmpty) {
                  return "Title cannot be empty";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                filled: true,
        fillColor: Colors.grey[100],
        hintText: 'Company name',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey),
        ),
            ),
              autofocus: true,
              controller: _companyController,),
          ),
          Row(children: <Widget>[
            SizedBox(width: 20,),
            Text("Contact details", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[100])),
          ],),
          Padding(
            padding: EdgeInsets.all(15),
            child: TextFormField(
              minLines: 3,
              maxLines: 10,
              validator: (value) {
                if(value.isEmpty) {
                  return "Title cannot be empty";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                filled: true,
        fillColor: Colors.grey[100],
        hintText: 'Email/mobile',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey),
        ),
            ),
              autofocus: true,
              controller: _contactController,),
          ),
          Row(children: <Widget>[
            SizedBox(width: 20,),
            Text("Reference materials (if any)", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,  color: Colors.grey[100])),
          ],),
          Padding(
            padding: EdgeInsets.all(15),
            child: TextFormField(
              minLines: 3,
              maxLines: 10,
              validator: (value) {
                if(value.isEmpty) {
                  return "Title cannot be empty";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                filled: true,
        fillColor: Colors.grey[100],
        hintText: 'Link',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey),
        ),
            ),
              autofocus: true,
              controller: _linkController,),
          ),
          Row(children: <Widget>[
            SizedBox(width: 20,),
            Text("Details", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,  color: Colors.grey[100])),
          ],),
          Container(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: TextFormField(
              validator: (value) {
                if(value.isEmpty) {
                  return "Content cannot be empty";
                } else {
                  return null;
                }
              },
              controller: _contentController,
              minLines: 10,
              maxLines: 15,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
        hintText: 'Details',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey),
        ),
            )
              ),
          ),
          ),
          RaisedButton(
            onPressed: () async { //upload and save to firebase

              await Provider.of(context).auth.getCurrentUser().then((user) {
              setState(() {
              profilePicture = user.photoUrl;
              username = user.displayName;
              });
              }).catchError((e) {
              print(e);
              });

              widget.post.title = _titleController.text;
              widget.post.content = _contentController.text;
              widget.post.timestamp = DateFormat('dd/MM/yyyy').format(DateTime.now()).toString();
              widget.post.profilePicture = profilePicture;
              widget.post.username = username;
              widget.post.link = _linkController.text;
              widget.post.company = _companyController.text;
              widget.post.contact = _contactController.text;
              
              
              final uid = await Provider.of(context).auth.getCurrentUID();
              widget.post.ownerid = uid;
              widget.post.saved = {uid: false};
              widget.post.upvotes =  {uid: false};
              
              final DocumentReference documentReference = 
              await db.collection("public").document("internship_offers").
              collection("Offers").add({ //add post into a collection
                'title': widget.post.title,
                'content': widget.post.content,
                'timestamp': widget.post.timestamp,
                'username': widget.post.username,
                'profilePicture' : widget.post.profilePicture,
                'documentid': '',
                'link': widget.post.link,
                'company': widget.post.company,
                'contact': widget.post.contact,
                'ownerid': widget.post.ownerid,
                'saved': widget.post.saved,
                'upvotes': widget.post.upvotes
              });

              final String documentid = documentReference.documentID;
               widget.post.documentid = documentid;

              await db.collection("public").document("internship_offers").
              collection("Offers").document(documentid).updateData({
                'documentid': documentid,
              });

              await db.collection('users').document(uid).
              collection('private_offers').document(documentid).setData({
                'title': widget.post.title,
                'content': widget.post.content,
                'timestamp': widget.post.timestamp,
                'username': widget.post.username,
                'profilePicture' : widget.post.profilePicture,
                'documentid': documentid,
                'link': widget.post.link,
                'company': widget.post.company,
                'contact': widget.post.contact,
                'ownerid': widget.post.ownerid,
                'saved': widget.post.saved,
                'upvotes': widget.post.upvotes
              });
              
              Navigator.pop(context);
              

            },
            color: Colors.blue[300],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
              child: Text("Post", style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  ),
                  ),
          
        ],
      ),),
        )
    );
  }
}


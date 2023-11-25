import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:multichatapp/const/const.dart';

class RequestFriendScreen extends StatefulWidget {
  const RequestFriendScreen({super.key});

  @override
  State<RequestFriendScreen> createState() => _RequestFriendScreenState();
}

class _RequestFriendScreenState extends State<RequestFriendScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final CollectionReference sendRequestsCollection =
        firestore.collection('requests');

    return Scaffold(
        body: StreamBuilder(
      stream: sendRequestsCollection.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(
            color: Color.fromARGB(255, 15, 126, 80),
          ));
        }

        final iAmSenderDoc = snapshot.data!.docs.where((doc) {
          final checkSender = doc['senderId'];
          final reqStatus = doc['requestStatus'];
          if (checkSender == auth.currentUser!.uid) {
            return reqStatus == 'Pending' || reqStatus == 'Rejected';
          }
          return false;
        }).toList();

        if (iAmSenderDoc.isEmpty) {
          return const Center(
            child: Text('No Request Found'),
          );
        }

        return ListView.builder(
            itemCount: iAmSenderDoc.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        )
                      ]),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor:
                                iAmSenderDoc[index]['recieverProfile'] != ""
                                    ? Colors.transparent
                                    : const Color.fromARGB(255, 15, 126, 80),
                            child: SizedBox(
                              width: 60,
                              height: 60,
                              child: ClipOval(
                                child: iAmSenderDoc[index]['recieverProfile'] !=
                                        ""
                                    ? Image.network(
                                        iAmSenderDoc[index]['recieverProfile'])
                                    : const Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            iAmSenderDoc[index]['recieverName'],
                            style: const TextStyle(fontSize: 13),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${iAmSenderDoc[index]['requestStatus']}',
                            style: TextStyle(
                                fontSize: 13,
                                color: iAmSenderDoc[index]['requestStatus'] ==
                                        "Cancel"
                                    ? Colors.red
                                    : const Color.fromARGB(255, 15, 126, 80)),
                          ),
                          MaterialButton(
                            onPressed: () async {
                              if (iAmSenderDoc[index]['requestStatus'] ==
                                  "Rejected") {
                                await firestore.runTransaction(
                                    (Transaction transaction) async {
                                  transaction
                                      .delete(iAmSenderDoc[index].reference);
                                });
                              } else {
                                await firestore
                                    .collection('requests')
                                    .doc(iAmSenderDoc[index].id)
                                    .update({'requestStatus': 'Cancel'});
                              }
                            },
                            height: 30.0,
                            minWidth: 60.0,
                            textColor: Colors.white,
                            color: const Color.fromARGB(255, 15, 126, 80),
                            child: Text(
                              iAmSenderDoc[index]['requestStatus'] == "Rejected"
                                  ? "Delete Request"
                                  : "Cancel Request",
                              style: const TextStyle(fontSize: 13),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            });
      },
    ));
  }
}

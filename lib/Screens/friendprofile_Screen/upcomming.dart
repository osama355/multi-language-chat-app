import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:multichatapp/const/const.dart';

class UpcommingFriendScreen extends StatefulWidget {
  const UpcommingFriendScreen({super.key});

  @override
  State<UpcommingFriendScreen> createState() => _UpcommingFriendScreenState();
}

class _UpcommingFriendScreenState extends State<UpcommingFriendScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final CollectionReference recieveRequestCollection =
        FirebaseFirestore.instance.collection('requests');

    return Scaffold(
        body: StreamBuilder(
            stream: recieveRequestCollection.snapshots(),
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
              if (snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text("No Request yet"),
                );
              }
              final pendingRequest = snapshot.data!.docs.where((doc) {
                final recieverId = doc['recieverId'];
                if (recieverId == auth.currentUser!.uid) {
                  return doc.get('requestStatus') == 'Pending';
                }
                return false;
              }).toList();

              if (pendingRequest.isEmpty) {
                return const Center(child: Text("No Request yet"));
              }

              return ListView.builder(
                itemCount: pendingRequest.length,
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
                              ClipOval(
                                child: pendingRequest[index]['senderProfile'] !=
                                        ""
                                    ? Image.network(
                                        pendingRequest[index]['senderProfile'],
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover)
                                    : Container(
                                        width: 60,
                                        height: 60,
                                        decoration: const BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 15, 126, 80),
                                        ),
                                        child: const Icon(
                                          Icons.person,
                                          size: 40,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                pendingRequest[index]['senderName'],
                                style: const TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              ElevatedButton(
                                  onPressed: pendingRequest[index]
                                              ['requestStatus'] ==
                                          "Pending"
                                      ? () async {
                                          await firestore
                                              .collection('requests')
                                              .doc(pendingRequest[index].id)
                                              .update({
                                            'requestStatus': "Accepted"
                                          });
                                        }
                                      : null,
                                  child: const Text(
                                    "Accept",
                                    style: TextStyle(fontSize: 12),
                                  )),
                              const SizedBox(
                                width: 5,
                              ),
                              ElevatedButton(
                                  onPressed: pendingRequest[index]
                                              ['requestStatus'] ==
                                          'Pending'
                                      ? () async {
                                          firestore
                                              .collection('requests')
                                              .doc(pendingRequest[index].id)
                                              .update({
                                            'requestStatus': "Rejected"
                                          });
                                        }
                                      : pendingRequest[index]
                                                  ['requestStatus'] ==
                                              "Rejected"
                                          ? () {
                                              firestore.runTransaction(
                                                  (Transaction
                                                      transaction) async {
                                                transaction.delete(
                                                    pendingRequest[index]
                                                        .reference);
                                              });
                                            }
                                          : null,
                                  child: Text(
                                      pendingRequest[index]['requestStatus'] ==
                                                  'Pending' ||
                                              pendingRequest[index]
                                                      ['requestStatus'] ==
                                                  "Accepted"
                                          ? "Reject"
                                          : "Delete",
                                      style: const TextStyle(fontSize: 12)))
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }));
  }
}

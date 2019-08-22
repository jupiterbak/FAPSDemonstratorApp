import 'package:faps_demonstrator_customer_app/model/Order.dart';
import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const String routeName = "/order_details";

  @override
  OrderDetailsScreenState createState() => OrderDetailsScreenState();
}

class OrderDetailsScreenState extends State<OrderDetailsScreen> {
  // init the step to 0th position
  OrderModel selectedOrder;
  List<Step> steps = [];
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    this.selectedOrder = ModalRoute.of(context).settings.arguments;
    this.steps = this.selectedOrder.getAllStepWidgets();

    return Scaffold(
      // Appbar
      appBar: AppBar(
        // Title
        title: Text(selectedOrder !=null? selectedOrder.OrderID : "Production Order Details"),
      ),
      // Body
      body: Container(
          child: Stepper(
            // Using a variable here for handling the currentStep
            currentStep: this.currentStep,
            // List the steps you would like to have
            steps: steps,
            // Define the type of Stepper style
            // StepperType.horizontal :  Horizontal Style
            // StepperType.vertical   :  Vertical Style
            type: StepperType.vertical,
            // Know the step that is tapped
            onStepTapped: (step) {
              // On hitting step itself, change the state and jump to that step
              setState(() {
                // update the variable handling the current step value
                // jump to the tapped step
                currentStep = step;
              });
            },
            controlsBuilder: (BuildContext context,
                {VoidCallback onStepContinue, VoidCallback onStepCancel}) =>
                Container(),
          )
      ),
    );
  }
}

import 'package:equatable/equatable.dart';

abstract class AskToAdminScreenEvent extends Equatable{
  const AskToAdminScreenEvent();

  @override
  List<Object> get props => [];
}

class AskEvent extends AskToAdminScreenEvent{
final String title;
final String body;
const AskEvent(this.title, this.body);
}
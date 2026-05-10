import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// Event model representing a single event
class Event {
  final String id;
  final String title;
  final String description;
  final String category;
  final DateTime date;
  final TimeOfDay time;
  final String? imageUrl;
  final DateTime createdAt;
  final String userId; // To link event to user
  final bool isFavorite;

  Event({
    this.id = '',
    required this.title,
    required this.description,
    required this.category,
    required this.date,
    required this.time,
    this.imageUrl,
    DateTime? createdAt,
    this.userId = '',
    this.isFavorite = false,
  }) : createdAt = createdAt ?? DateTime.now();

  /// Convert Event to JSON for Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'category': category,
      'date': Timestamp.fromDate(date),
      'time': '${time.hour}:${time.minute}',
      'imageUrl': imageUrl,
      'createdAt': Timestamp.fromDate(createdAt),
      'userId': userId,
      'isFavorite': isFavorite,
    };
  }

  /// Create Event from Firestore document
  factory Event.fromMap(Map<String, dynamic> map, String documentId) {
    DateTime date;
    if (map['date'] is Timestamp) {
      date = (map['date'] as Timestamp).toDate();
    } else {
      date = DateTime.now();
    }
    
    final timeStr = map['time'] as String? ?? '00:00';
    final timeParts = timeStr.split(':');
    final time = TimeOfDay(
      hour: timeParts.isNotEmpty ? (int.tryParse(timeParts[0]) ?? 0) : 0,
      minute: timeParts.length > 1 ? (int.tryParse(timeParts[1]) ?? 0) : 0,
    );

    DateTime createdAt;
    if (map['createdAt'] is Timestamp) {
      createdAt = (map['createdAt'] as Timestamp).toDate();
    } else {
      createdAt = DateTime.now();
    }

    return Event(
      id: documentId,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      date: date,
      time: time,
      imageUrl: map['imageUrl'],
      createdAt: createdAt,
      userId: map['userId'] ?? '',
      isFavorite: map['isFavorite'] ?? false,
    );
  }

  /// Create a copy with modifications
  Event copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    DateTime? date,
    TimeOfDay? time,
    String? imageUrl,
    DateTime? createdAt,
    String? userId,
    bool? isFavorite,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      date: date ?? this.date,
      time: time ?? this.time,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

/// Provider for managing events with Firestore
class EventListProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  List<Event> _events = [];
  bool _isLoading = false;
  String? _error;

  List<Event> get events => _events;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Get events stream from Firestore (real-time updates)
  Stream<List<Event>> getEventsStream({String? userId}) {
    try {
      Query query = _firestore.collection('events');
      
      // Filter by userId if provided
      if (userId != null && userId.isNotEmpty) {
        query = query.where('userId', isEqualTo: userId);
      }
      
      // We perform sorting client-side to avoid the need for composite indexes in Firestore
      // which often causes "failed-precondition" errors for new projects.
      return query.snapshots().map((snapshot) {
        final events = snapshot.docs.map((doc) {
          return Event.fromMap(doc.data() as Map<String, dynamic>, doc.id);
        }).toList();
        
        // Sort by createdAt descending (newest first)
        events.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        return events;
      }).handleError((error) {
        debugPrint('Error in getEventsStream: $error');
        _error = error.toString();
        throw error;
      });
    } catch (e) {
      debugPrint('Exception in getEventsStream: $e');
      return Stream.error(e);
    }
  }

  /// Get events by category stream (real-time updates)
  Stream<List<Event>> getEventsByCategoryStream(String category, {String? userId}) {
    try {
      // If category is "All" or equivalent, use getEventsStream
      if (category.toLowerCase() == 'all' || category == 'كل') {
        return getEventsStream(userId: userId);
      }

      Query query = _firestore
          .collection('events')
          .where('category', isEqualTo: category);
      
      if (userId != null && userId.isNotEmpty) {
        query = query.where('userId', isEqualTo: userId);
      }
      
      // Perform sorting client-side to avoid requiring composite indexes
      return query.snapshots().map((snapshot) {
        final events = snapshot.docs.map((doc) {
          return Event.fromMap(doc.data() as Map<String, dynamic>, doc.id);
        }).toList();
        
        events.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        return events;
      }).handleError((error) {
        debugPrint('Error in getEventsByCategoryStream: $error');
        _error = error.toString();
        throw error;
      });
    } catch (e) {
      debugPrint('Exception in getEventsByCategoryStream: $e');
      return Stream.error(e);
    }
  }

  /// Add a new event to Firestore
  Future<bool> addEvent(Event event) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Add event to Firestore
      await _firestore.collection('events').add(event.toMap());
      
      _isLoading = false;
      notifyListeners();
      return true;
    } on FirebaseException catch (e) {
      _error = _handleFirebaseError(e);
      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      _error = 'Failed to add event: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Update an existing event
  Future<bool> updateEvent(Event event) async {
    if (event.id.isEmpty) {
      _error = 'Event ID is required for update';
      return false;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _firestore.collection('events').doc(event.id).update(event.toMap());
      
      _isLoading = false;
      notifyListeners();
      return true;
    } on FirebaseException catch (e) {
      _error = _handleFirebaseError(e);
      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      _error = 'Failed to update event: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Delete an event
  Future<bool> deleteEvent(String eventId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _firestore.collection('events').doc(eventId).delete();
      
      _isLoading = false;
      notifyListeners();
      return true;
    } on FirebaseException catch (e) {
      _error = _handleFirebaseError(e);
      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      _error = 'Failed to delete event: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Toggle favorite status of an event
  Future<void> toggleFavorite(Event event) async {
    try {
      await _firestore.collection('events').doc(event.id).update({
        'isFavorite': !event.isFavorite,
      });
    } catch (e) {
      _error = 'Failed to toggle favorite: $e';
      notifyListeners();
    }
  }

  /// Get favorite events stream
  Stream<List<Event>> getFavoriteEventsStream({String? userId}) {
    try {
      Query query = _firestore
          .collection('events')
          .where('isFavorite', isEqualTo: true);
      
      if (userId != null && userId.isNotEmpty) {
        query = query.where('userId', isEqualTo: userId);
      }
      
      // Perform sorting client-side
      return query.snapshots().map((snapshot) {
        final events = snapshot.docs.map((doc) {
          return Event.fromMap(doc.data() as Map<String, dynamic>, doc.id);
        }).toList();
        
        events.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        return events;
      }).handleError((error) {
        debugPrint('Error in getFavoriteEventsStream: $error');
        throw error;
      });
    } catch (e) {
      return Stream.error(e);
    }
  }

  /// Load events from Firestore once
  Future<void> loadEvents({String? userId}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      Query query = _firestore.collection('events');
      
      if (userId != null && userId.isNotEmpty) {
        query = query.where('userId', isEqualTo: userId);
      }
      
      final snapshot = await query.orderBy('createdAt', descending: true).get();
      
      _events = snapshot.docs.map((doc) {
        return Event.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
      
      _isLoading = false;
      notifyListeners();
    } on FirebaseException catch (e) {
      _error = _handleFirebaseError(e);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Failed to load events: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Clear error message
  void clearError() {
    _error = null;
    notifyListeners();
  }

  /// Handle Firebase specific errors
  String _handleFirebaseError(FirebaseException e) {
    switch (e.code) {
      case 'permission-denied':
        return 'You don\'t have permission to perform this action.';
      case 'not-found':
        return 'Event not found.';
      case 'already-exists':
        return 'Event already exists.';
      case 'unavailable':
        return 'Service temporarily unavailable. Please try again.';
      case 'unauthenticated':
        return 'Please sign in to manage events.';
      case 'failed-precondition':
        return 'Operation precondition failed.';
      default:
        return 'Error: ${e.message ?? e.code}';
    }
  }
}

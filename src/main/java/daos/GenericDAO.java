package daos;

import java.util.List;

/**
 * Generic DAO interface that defines common CRUD operations
 * @param <T> The model class type
 * @param <K> The primary key type (usually Integer)
 */
public interface GenericDAO<T, K> {
    
    /**
     * Create a new entity in the database
     * @param entity The entity to create
     * @return true if successful, false otherwise
     */
    boolean create(T entity);
    
    /**
     * Retrieve an entity by its ID
     * @param id The entity's ID
     * @return The entity if found, null otherwise
     */
    T getById(K id);
    
    /**
     * Retrieve all entities
     * @return List of all entities
     */
    List<T> getAll();
    
    /**
     * Update an existing entity in the database
     * @param entity The entity to update
     * @return true if successful, false otherwise
     */
    boolean update(T entity);
    
    /**
     * Delete an entity from the database
     * @param id The entity's ID
     * @return true if successful, false otherwise
     */
    boolean delete(K id);
}
